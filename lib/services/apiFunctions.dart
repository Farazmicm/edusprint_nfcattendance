import 'dart:convert' as convert;
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nfcdemo/enum/enum.dart';
import 'package:nfcdemo/models/changePasswordModel.dart';
import 'package:nfcdemo/models/forgotPasswordModel.dart';
import 'package:nfcdemo/models/newTokenModel.dart';
import 'package:nfcdemo/models/schoolGroupCodeModel.dart';
import 'package:nfcdemo/utilities/constants.dart';
import 'package:nfcdemo/utilities/utility.dart';

import '../models/contactusModel.dart';

Map<String, String> headers = {
  'Content-type': 'application/x-www-form-urlencoded',
  'Accept': 'application/json',
};

late dynamic oResponse;

//School Group code login
Future<SchoolGroupWiseLoginModel> schoolGroupShortCodeLogin(
    String schoolGroupShortName) async {
  try {
    String oUrl =
        'http://mobileapiv2.edusprint.in/Home/GetSchoolGroupDetails?schoolshortcode=${schoolGroupShortName.trim()}';

    oResponse = await http.get(Uri.parse(oUrl)).then((http.Response response) {
      return SchoolGroupWiseLoginModel.fromJson(
          convert.jsonDecode(response.body));
    }).catchError((e) {
      syncError("schoolGroupShortCodeLogin", e);
    });

    if (oResponse.ClientID > 0) {
      //if (await Utility.clearLocalStorage()) {
      //Set Global Variable
      ClientWEBURL = oResponse.ClientWEBURL ?? "";
      ClientShortCode = oResponse.ClientShortCode ?? "";

      //Write Local Storage
      await Utility.writeLocalStorage(
          localStorageKeyEnum.SchoolGroupLoginResponse.toString(),
          convert.jsonEncode(oResponse));
      await Utility.writeLocalStorage(
          localStorageKeyEnum.ClientWEBURL.toString(), ClientWEBURL);
      await Utility.writeLocalStorage(
          localStorageKeyEnum.ClientShortCode.toString(), ClientShortCode);
      //}
    }
    return oResponse;
  } catch (e) {
    throw (e);
  }
}

//New Token
Future<NewTokenModel> getNewToken() async {
  try {
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Mobile/GetNewToken?IMR=1&Cookies=IMR=1';
    oResponse = await http.get(Uri.parse(oUrl)).then((
      http.Response response,
    ) {
      return NewTokenModel.fromJson(convert.jsonDecode(response.body));
    }).catchError((e) {
      syncError("getNewToken", e);
    });

    Token = oResponse.ResponseData;
    await Utility.removeLocalStorageKey(localStorageKeyEnum.Token.toString());
    await Utility.writeLocalStorage(
        localStorageKeyEnum.Token.toString(), oResponse.ResponseData);
    return oResponse;
  } catch (e) {
    throw (e);
  }
}

//User login
Future<dynamic> userSignInPost(
    TextEditingController userName, TextEditingController password) async {
  try {
    String oUrl =
        ClientWEBURL + '/' + ClientShortCode + '/Security/Login/MCampusLogin';
    Map body = {
      'SiteUserName': userName.text,
      'SitePassword': password.text,
      'RememberMe': 'false',
    };
    headers['IMR'] = '1';
    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token;IMR=1';

    return await http
        .post(Uri.parse(oUrl), headers: headers, body: body)
        .then((http.Response response) {
      return convert.jsonDecode(response.body);
    });
  } catch (e) {}
}

//Get VerificationCode
Future<ForgotPasswordModel> verificationCodePost(
    TextEditingController userName, bool isVerificationCode) async {
  try {
    String oUrl = ClientWEBURL + '/' + ClientShortCode;
    if (isVerificationCode)
      oUrl +=
          '/Security/Login/ForgotPassword?ForgotPassword.UserName=${userName.text}';
    else
      oUrl +=
          '/UserManagement/user/GetUserProfileByUserName?SMUserName_Values=${userName.text}';

    return await http.post(Uri.parse(oUrl)).then((http.Response response) {
      return ForgotPasswordModel.fromJson(convert.jsonDecode(response.body));
    });
  } catch (e) {
    throw (e);
  }
}

//Forgot Password
Future<ForgotPasswordModel> forgotPasswordPost(TextEditingController userName,
    TextEditingController password, TextEditingController oTP) async {
  try {
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/' +
        'Security/Login/UserVerification?UserVerification.UserName=${userName.text}&UserVerification.Password=${password.text}&UserVerification.VerificationCode=${oTP.text}';

    headers['IMR'] = '1';
    headers['Cookies'] = 'IMR=1';
    return await http
        .post(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      return ForgotPasswordModel.fromJson(convert.jsonDecode(response.body));
    });
  } catch (e) {
    throw (e);
  }
}

//Change Password
Future<ChangePasswordResponseModel> changePasswordPost(
    ChangePasswordModel changePasswordModel) async {
  try {
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Mobile/ChangePasswordFromMobile?UserID=${changePasswordModel.UserID}&UpdatedOn=${changePasswordModel.UpdatedOn}&OldPassword=${changePasswordModel.OldPassword}&NewPassword=${changePasswordModel.NewPassword}';

    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token';

    return await http
        .post(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      return ChangePasswordResponseModel.fromJson(
          convert.jsonDecode(response.body));
    });
  } catch (e) {
    //throw (await syncError("changePasswordPost", e));
    throw (e);
  }
}

//Branch Selection
Future<dynamic> branchSelectionPost(
    String studentID, String studentYearMasterID) async {
  try {
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Dashboard/Dashboard/StudentYearSelectionPost?ECampusStudentID=$studentID&ECampusStudentYearMasterID=$studentYearMasterID';
    return await http
        .post(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      return convert.jsonDecode(response.body);
    });
  } catch (e) {
    //await syncError("branchSelectionPost", e);
  }
  return true;
}

Future<bool> syncError(String methodName, Object error) async {
  try {
    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token';
    Map<String, dynamic> errorLog = {"MethodName": methodName, "Error": error};
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Error/HandleMobileDBError?pMobileErrorLog=$errorLog';
    var oResponse = await http
        .post(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      return convert.jsonDecode(response.body);
    });

    if (oResponse["Success"])
      return true;
    else
      return false;
  } catch (e) {
    throw ("Error:$e");
  }
}

Future<bool> verifyLogin(String methodName, Object error) async {
  try {
    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token';
    Map<String, dynamic> errorLog = {"MethodName": methodName, "Error": error};
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Error/HandleMobileDBError?pMobileErrorLog=$errorLog';
    var oResponse = await http
        .post(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      return convert.jsonDecode(response.body);
    });

    if (oResponse["Success"])
      return true;
    else
      return false;
  } catch (e) {
    throw ("Error:$e");
  }
}

Future<dynamic> getStudentProfileData() async {
  try {
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        "/Mobile/GetStudentDetails?StudentID=$UserID&YearMasterID=$yearMasterID";

    headers['IMR'] = '1';
    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token;IMR=1';

    return await http
        .post(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      return convert.jsonDecode(response.body);
    });
  } catch (e) {}
}

Future<dynamic> getParentProfileData() async {
  try {
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        "/Mobile/GetStudentParentDetails?StudentID=$UserID";

    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token';

    return await http
        .post(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      return convert.jsonDecode(response.body);
    });
  } catch (e) {}
}

//Get Student Attendance
Future<dynamic> getStudentAttendance() async {
  try {
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Mobile/GetStudentAttendance?StudentID=${UserID}&YearMasterID=$yearMasterID';

    headers['IMR'] = '1';
    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token;IMR=1';

    oResponse = await http
        .post(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      return convert.jsonDecode(response.body);
    });

    // //Write Local Storage
    // Utility.writeLocalStorage(localStorageKeyEnum.StudentAttendance.toString(),
    //     convert.jsonEncode(oResponse));

    return oResponse;
  } catch (e) {
    //syncError("getStudentAttendance", e);
  }
}

//Get Log Book Information
Future<dynamic> getLogBookInformation() async {
  try {
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Mobile/GetLogBookInformation?StudentID=${UserID}&ClassMasterID=${classMasterID}&DivisionMasterID=${divisionMasterID}&SchoolID=${schoolID}&YearMasterID=$yearMasterID';

    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token';

    oResponse = await http
        .post(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      return convert.jsonDecode(response.body);
    });

    // //Write Local Storage
    // await Utility.writeLocalStorage(
    //     localStorageKeyEnum.LogBookInformation.toString(),
    //     convert.jsonEncode(oResponse));

    return oResponse;
  } catch (e) {
    //syncError("getLogBookInformation", e);
  }
}

//Get Event information
Future<dynamic> getEventInformation() async {
  try {
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Mobile/GetStudentEventCalendar?StudentID=${UserID}&YearID=${yearMasterID}&SchoolID=$schoolID';

    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token';

    oResponse = await http
        .post(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      return convert.jsonDecode(response.body);
    });
    // //Write Local Storage
    // await Utility.writeLocalStorage(
    //     localStorageKeyEnum.EventInformation.toString(),
    //     convert.jsonEncode(oResponse));
    return oResponse;
  } catch (e) {
    //syncError("getEventInformation", e);
  }
}

//Get TimeTable
Future<dynamic> getTimeTableDetails() async {
  try {
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Mobile/GetStudentTimeTableInformation?StudentID=${UserID}&YearID=${yearMasterID}&SchoolID=$schoolID';

    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token';

    return await http
        .post(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      return convert.jsonDecode(response.body);
    });
  } catch (e) {
    print(e);
    //syncError("getTimeTable", e);
  }
}

//Get Ecampus info
Future<dynamic> getEcampusInfo(String moduleType) async {
  try {
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Mobile/GetEcampusModuleByType?YearMasterID=$yearMasterID&ModuleType=$moduleType';

    headers['IMR'] = '1';
    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token;IMR=1';

    oResponse = await http
        .post(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      return convert.jsonDecode(response.body);
    });
    return oResponse;
  } catch (e) {
    print(e);
    // syncError("getEcampusInfo", e);
  }
}

//Get Ecampus info
Future<dynamic> getGetEcampusData(String moduleName) async {
  try {
    String oUrl =
        ClientWEBURL + '/' + ClientShortCode + '/Mobile/GetEcampusData';
    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token';

    Map oBody = {
      'StudentID': UserID,
      //  'SubjectIDs': ''
      'HouseID': houseID,
      'GenderID': genderID,
      'SectionMasterID': sectionMasterID,
      'SchoolGroupID': schoolGroupID,
      'ClassMasterID': classMasterID,
      'DivisionMasterID': divisionMasterID,
      'SchoolID': schoolID,
      'YearMasterID': yearMasterID,
      'ModuleName': moduleName,
    };

    oResponse = await http
        .post(Uri.parse(oUrl), headers: headers, body: oBody)
        .then((http.Response response) {
      print("getECampusDetail Response: " + response.body);
      return convert.jsonDecode(response.body);
    });
    return oResponse;
  } catch (e) {
    print("getECampusDetail API: " + e.toString());
    //syncError("getGetEcampusData", e);
  }
}

Future<dynamic> ecampusWebFromURL(String type) async {
  try {
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Mobile/GetURLFromMobile?StudentID=${UserID}&YearID=${yearMasterID}&SchoolID=${schoolID}&requestType=$type';

    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token;IMR=1';
    headers['Set-Cookie'] = 'MCampusTokenID=$Token';

    return http
        .post(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      return response.body;
    });
  } catch (e) {
    print(e);
    //syncError("ecampusWebFromURL", e);
  }
}

Future<String> downloadFile(String url, String fileName, String dir) async {
  HttpClient httpClient = new HttpClient();
  File file;
  String filePath = '';
  String myUrl = '';

  try {
    myUrl = url + '/' + fileName;
    var request = await httpClient.getUrl(Uri.parse(myUrl));
    var response = await request.close();
    if (response.statusCode == 200) {
      var bytes = await consolidateHttpClientResponseBytes(response);
      filePath = '$dir/$fileName';
      file = File(filePath);
      await file.writeAsBytes(bytes);
    } else
      filePath = 'Error code: ' + response.statusCode.toString();
  } catch (ex) {
    filePath = 'Can not fetch url';
  }

  return filePath;
}

//region New AP
Future<dynamic> userSignInPostNew(String userName, String password) async {
  try {
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Security/Login/MCampusLoginVerify';
    Map<String, String> body = {
      'SiteUserName': userName,
      'SitePassword': password,
      'RememberMe': 'false',
      'nfcdemo': '1'
    };

    headers['IMR'] = '1';
    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token;IMR=1;';

    oResponse = await http
        .post(Uri.parse(oUrl), headers: headers, body: body)
        .then((http.Response response) {
      return convert.jsonDecode(response.body);
    }).catchError((error) {});
    /*
    * StatusCode: 0 => No Error / Branch Year Selection (If SchoolId and YearMaster Id not received from setting)
    * StatusCode: 3 => First time Login (Message: Please login using browser and change your password first.)
    * StatusCode: 4 => Password Is Wrong (Message: Password Is Invalid.) | Username not Exist (Message: Username Does Not Exist.)
    * StatusCode: 5 => Student Deactivate (Message: Student Deactivated)
    *
    * User.IsChangePasswordRequired => true -> send to Change Password Screen
    * User.IsLocked => true -> Show Message and If already login logout from device
    *
    * */

    return oResponse;
  } catch (e) {
    print('Error Catch:' + convert.jsonEncode(e));
    throw (await syncError("userSignInPost", e));
  }
}

Future<dynamic> getStudentDashboardData(
    String studentID, String yearMasterID) async {
  try {
    //'/Portal/Default/Index'
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Mobile/GetStudentDashboardDetails?StudentID=$studentID&YearMasterID=$yearMasterID';
    Map<String, dynamic> body = {
      'StudentID': studentID,
      'YearMasterID': yearMasterID,
    };

    headers['IMR'] = '1';
    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token;IMR=1;';

    return await http
        .get(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      return convert.jsonDecode(response.body);
    }).catchError((error) {});
  } catch (e) {
    print('Error Catch:' + convert.jsonEncode(e));
  }
}

Future<dynamic> getStudentYears(String studentID) async {
  try {
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Mobile/GetStudentYearsByStudentID?StudentID=$studentID';

    headers['IMR'] = '1';
    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token;IMR=1;';

    return await http
        .get(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      //print('GetStudentYearsByStudentID Response:\n' + response.body);
      return convert.jsonDecode(response.body);
    }).catchError((error) {});
  } catch (e) {
    print('getStudentYears:' + convert.jsonEncode(e));
  }
}

//Branch Selection
Future<dynamic> branchSelectionPostNew(
    String studentID, String studentYearMasterID) async {
  try {
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Mobile/StudentYearSelectionPost?ECampusStudentID=$studentID&ECampusStudentYearMasterID=$studentYearMasterID';
    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token';
    return await http
        .post(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      if (response.body.contains("Object moved to")) {
        return "";
      } else {
        return convert.jsonDecode(response.body);
      }
    });
  } catch (e) {
    //await syncError("branchSelectionPost", e);
  }
  return true;
}

//endregion
Future<bool> logOutUser() async {
  try {
    String oUrl =
        ClientWEBURL + '/' + ClientShortCode + '/Security/Login/SignOut';

    headers['IMR'] = '1';
    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token;IMR=1;';
    //headers['LogoutMobileDeviceID'] = '';
    var oResponse = await http
        .get(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      return convert.jsonDecode(response.body);
    });
    if (oResponse != null)
      return true;
    else
      return false;
  } catch (e) {
    print('logOutUser:' + convert.jsonEncode(e));
    throw ('logOutUser:' + convert.jsonEncode(e));
  }
}

//Student medical details
Future<dynamic> getStudentFeesDetail() async {
  try {
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Mobile/GetFeesData?StudentID=$UserID&SchoolID=$schoolID&YearMasterID=$yearMasterID';

    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token';

    return await http
        .post(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      return convert.jsonDecode(response.body);
    });
  } catch (e) {
    //await syncError("getStudentMedicalDetail", e);
  }
}

//Student medical details
Future<dynamic> getStudentMedicalDetail() async {
  try {
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Mobile/GetMedicalDetails?StudentID=$UserID';

    headers['IMR'] = '1';
    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token;IMR=1';

    return await http
        .post(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      return convert.jsonDecode(response.body);
    });
  } catch (e) {
    // await syncError("getStudentMedicalDetail", e);
  }
}

//Report Card Details
Future<dynamic> getReportCard() async {
  try {
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Mobile/StudentReportCardList?StudentID=$UserID';

    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token';

    return await http
        .post(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      return convert.jsonDecode(response.body);
    });
  } catch (e) {
    print(e);
    //await syncError("getReportCard", e);
  }
}

//Contactus details
Future<dynamic> getContactus() async {
  try {
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Mobile/GetSchoolDetails?SchoolID=$schoolID';
    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token';
    return await http
        .patch(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) => convert.jsonDecode(response.body));
  } catch (e) {
    print(e);
  }
}

Future<bool> verifyFile(String filePath) async {
  try {
    if (filePath.isEmpty || filePath == "-") return false;
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Mobile/VerifyFile?filePath=$filePath';
    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token';
    return await http
        .patch(Uri.parse(oUrl), headers: headers)
        .then((http.Response response) {
      if (response.body == "True")
        return true;
      else
        return false;
    });
  } catch (e) {
    print(e);
    return false;
  }
}

Future<dynamic> postContactus(ContactusModel contactusModel) async {
  try {
    String oUrl =
        ClientWEBURL + '/' + ClientShortCode + '/Security/Login/ContactUs';

    Map<String, String> body = {
      'SchoolID': contactusModel.schoolID,
      'Name': contactusModel.name,
      'Address': contactusModel.address,
      'Phone': contactusModel.phone,
      'Email': contactusModel.email,
      'ContactSubject': contactusModel.contactSubject,
      'ContactMessage': contactusModel.contactMessage,
      'ContactByPhone': contactusModel.contactByPhone.toString(),
      'ContactByEmail': contactusModel.contactByEmail.toString(),
    };

    headers['IMR'] = '1';
    headers['MCampusTokenID'] = Token;
    headers['Cookies'] = 'MCampusTokenID=$Token;IMR=1;';

    return await http
        .post(Uri.parse(oUrl), headers: headers, body: body)
        .then((http.Response response) {
      return convert.jsonDecode(response.body);
    }).catchError((error) {});
  } catch (e) {
    print(e);
  }
}
