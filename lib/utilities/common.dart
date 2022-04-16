import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ndialog/ndialog.dart';
import 'package:nfcdemo/database_mng/repository/userdetails_repository.dart';
import 'package:nfcdemo/enum/enum.dart';
import 'package:nfcdemo/models/VWStudentFullDetailNullable.dart';
import 'package:nfcdemo/models/changePasswordModel.dart';
import 'package:nfcdemo/models/dropdownModel.dart';
import 'package:nfcdemo/models/models.dart';
import 'package:nfcdemo/services/apiFunctions.dart';
import 'package:nfcdemo/ui/login/branchSelection.dart';
import 'package:nfcdemo/ui/login/firstTimeChangePassword.dart';
import 'package:nfcdemo/utilities/utility.dart';
import 'package:nfcdemo/widgets/global_context.dart';
import 'package:nfcdemo/widgets/widgets.dart';

import 'constants.dart';

Future insertStudentFullDetail(Map<String, dynamic> oResponse) async {
  try {
    var oVWStudentFullDetailNullable = oResponse["VWStudentFullDetailNullable"];
    var oVWFullDetails =
        VWStudentFullDetailNullable.fromJson(oVWStudentFullDetailNullable);
    await Utility.writeLocalStorage(
        localStorageKeyEnum.StudentFullDetail.toString(),
        convert.jsonEncode(oResponse));
    await Utility.writeLocalStorage(
        localStorageKeyEnum.LstMobileAppLeftMenu.toString(),
        convert.jsonEncode(oResponse["LstMobileAppLeftMenu"]));
    await Utility.writeLocalStorage(localStorageKeyEnum.UserID.toString(),
        oVWFullDetails.UserID.toString());

    //Add User Details to DB
    try {
      //await DatabaseProvider.initHive();
      await UserDetailsRepository.getUserDetailsByID(oVWFullDetails.UserID)
          .then((value) async {
        if (value.UserID > 0) {
          await UserDetailsRepository.deleteUserDetails(oVWFullDetails.UserID)
              .then((value) async {
            if (value) {
              await UserDetailsRepository.addUserDetails(oVWFullDetails)
                  .then((value) {
                print("User Updated");
              });
            }
          });
        } else {
          await UserDetailsRepository.addUserDetails(oVWFullDetails)
              .then((value) async {
            // print("User Added: " + value.toString());
            if (value == 0) {
              await UserDetailsRepository.addUserDetails(oVWFullDetails)
                  .then((idvalue) {
                // print("Add Users: " + idvalue.toString());
              });
            }
          });
        }
      });
    } catch (e) {
      print("Error in add users to DB " + e.toString());
    }
  } catch (e) {
    print("Errorddddddd:: " + e.toString());
    //await syncError("InsertStudentFullDetail", e);
  }
}


Future setConstantValue() async {
  try {
    ClientWEBURL = await Utility.readLocalStorage(
        localStorageKeyEnum.ClientWEBURL.toString());
    ClientShortCode = await Utility.readLocalStorage(
        localStorageKeyEnum.ClientShortCode.toString());
    Token =
        await Utility.readLocalStorage(localStorageKeyEnum.Token.toString());

    imageFileHostedPath = ClientWEBURL + '/?imageFileHostedPath=';

    if (ClientWEBURL != "") {
      Map<String, dynamic> oStudentFullDetail = convert.jsonDecode(
          await Utility.readLocalStorage(
              localStorageKeyEnum.StudentFullDetail.toString()));

      var oVWStudentFullDetailNullable =
          oStudentFullDetail["VWStudentFullDetailNullable"];

      var oSchool = oStudentFullDetail["School"];

      print(convert.jsonEncode(oSchool));

      UserID = oVWStudentFullDetailNullable["StudentID"].toString();
      yearMasterID = oVWStudentFullDetailNullable["YearMasterID"].toString();
      studentYearID = oVWStudentFullDetailNullable["StudentYearID"].toString();
      schoolGroupID = oSchool["SchoolGroupID"].toString();
      schoolID = oVWStudentFullDetailNullable["SchoolID"].toString();
      sectionMasterID =
          oVWStudentFullDetailNullable["SectionMasterID"].toString();
      classMasterID = oVWStudentFullDetailNullable["ClassMasterID"].toString();
      divisionMasterID =
          oVWStudentFullDetailNullable["DivisionMasterID"].toString();
      houseID = oVWStudentFullDetailNullable["HouseID"].toString();
      genderID = oVWStudentFullDetailNullable["GenderID"].toString();
      uID = oVWStudentFullDetailNullable["UID"].toString();
      schoolName = oSchool["SchoolName"].toString();
      schoolLogoImage = oSchool["SchoolLogoImage"] != null
          ? oSchool["SchoolLogoImage"].toString()
          : "";
      schoolImage = oSchool["SchoolImage"] != null
          ? oSchool["SchoolImage"].toString()
          : "";

      var studentYearLst = List.from(convert.jsonDecode(
              await Utility.readLocalStorage(
                  localStorageKeyEnum.StudentYears.toString())))
          .map((e) => StudentYears.fromJson(e))
          .toList();
      var objStudentYears = studentYearLst.firstWhere(
          (element) => element.YearMasterID == int.parse(yearMasterID));
      if (objStudentYears != null) {
        yearStartDate = objStudentYears.StartDate;
        yearEndDate = objStudentYears.EndDate;
      }
    }
  } catch (e) {
    print(e);
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

String enumToShortString(String value) {
  return value.split('.').last;
}

Future<void> switchUser(int userId) async {
  try {
    ProgressDialog dialog =
        ProgressDialog(GlobalContext.navigatorKey.currentContext!,
            blur: 2,
            dialogTransitionType: DialogTransitionType.Shrink,
            message: CustomText(content: "Switching user...."),
            dialogStyle: DialogStyle(
              elevation: 5,
            ),
            dismissable: false);

    dialog.show();
    await UserDetailsRepository.getUserByID(userId).then((oUsertoSwitch) async {
      //School group login
      await schoolGroupShortCodeLogin(oUsertoSwitch.ExSchoolGroupCode!)
          .then((value) async {
        if (value.ClientID > 0) {
          await getNewToken().then((value) async {
            await userSignInPostNew(oUsertoSwitch.ExUserName.toString(),
                    oUsertoSwitch.Password.toString())
                .then((oRes) async {
              var oUser = User.fromJson(oRes["User"]);
              oUser.Password = oUsertoSwitch.Password;
              oUser.ExSchoolGroupCode = ClientShortCode;

              await verifyUser(oRes, oUser).then((value) async {
                await processUserLogin(value);
              });
            });
          });
        } else
          dialog.dismiss();
      });
    });
  } catch (e) {
    print("switchUser: " + e.toString());
  }
}

Future<UserVerificationResult> verifyUser(
    Map<String, dynamic> oData, User user) async {
  UserVerificationResult<User> oUserVerificationResult =
  UserVerificationResult<User>(isVerified: false, statusCode: "-1");

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

  try {
    if (oData.isNotEmpty) {
      var oStatusCode = oData["StatusCode"];
      var oResponseMessage = oData["ResponseMessage"];
      oUserVerificationResult.responseData = oData;
      if (oStatusCode != null) {
        switch (oStatusCode.toString()) {
          case "3": //First time Login (Message: Please login using browser and change your password first.)
            {
              //#region Code First Time change password

              oUserVerificationResult.isVerified = true;
              oUserVerificationResult.statusCode = "3";
              oUserVerificationResult.responseMessge = "PasswordChangeScreen";
              oUserVerificationResult.object = user;
              //#endregion
              break;
            }
          case "4": //Password Is Wrong (Message: Password Is Invalid.) | Username not Exist (Message: Username Does Not Exist.)
            {
              //#region Code Invalid
              oUserVerificationResult.isVerified = false;
              oUserVerificationResult.statusCode = "4";
              oUserVerificationResult.responseMessge = oResponseMessage;

              //#endregion
              break;
            }
          case "5": //Student Deactivate (Message: Student Deactivated)
            {
              //#region Code Deactivate
              //dialog.dismiss();
              //customAlertForError(context, 'Invalid', oResponseMessage);

              oUserVerificationResult.isVerified = false;
              oUserVerificationResult.statusCode = "5";
              oUserVerificationResult.responseMessge = oResponseMessage;

              //Need to Call Logout method.
              //#endregion
              break;
            }
          case "0": //No Error / Branch Year Selection (If SchoolId and YearMaster Id not received from setting)
            {
              //#region Code
              bool oSuccess = oData["Success"].toString() == "true";
              if (oSuccess == true) {
                if (user.UserID > 0) {
                  try {
                    oUserVerificationResult.isVerified = true;
                    oUserVerificationResult.statusCode = "0";
                    oUserVerificationResult.responseMessge = "UserLoggedIn";
                    oUserVerificationResult.object = user;
                  } catch (e) {
                    print("Err:: 00" + e.toString());
                  }
                } else {
                  //#region Code
                  /*dialog.dismiss();
                  customAlertForError(
                      context, 'Edusprint+', oResponseMessage);*/

                  //Need to Call Logout method.
                  //#endregion
                }
              }
              //#endregion Code
              break;
            }
          default:
            {
              break;
            }
        }

        //save user to db
        if (oUserVerificationResult.object!.UserID > 0) {
          await UserDetailsRepository.getUserByID(
              oUserVerificationResult.object!.UserID)
              .then((userObj) async {
            if (userObj.UserID > 0) {
              await UserDetailsRepository.deleteUser(
                  oUserVerificationResult.object!.UserID)
                  .then((addUser) async {
                if (addUser) {
                  await UserDetailsRepository.addUser(
                      oUserVerificationResult.object!)
                      .then((updateUser) {
                    print("User is Updated...");
                  });
                }
              });
            } else {
              await UserDetailsRepository.addUser(
                  oUserVerificationResult.object!)
                  .then((addUser) async {
                if (addUser > 0) {
                  print("User is Adddded..");
                } else {
                  await UserDetailsRepository.addUser(
                      oUserVerificationResult.object!)
                      .then((updateUser) {
                    print("User is Added...!!!");
                  });
                }
              });
            }
          });
        }
        //
      }
    }
  } catch (e) {
    print("Errrrror:: " + e.toString());
  }
  return oUserVerificationResult;
}

Future<void> processUserLogin(
    UserVerificationResult userVerificationResult) async {
  var context = GlobalContext.navigatorKey.currentContext!;
  if (userVerificationResult != null &&
      userVerificationResult.statusCode != "-1") {
    try {
      var oRes = userVerificationResult.responseData!;
      var dialog = ProgressDialog(context);
      switch (userVerificationResult.statusCode) {
        case "-1":
          {
            dialog.dismiss();
            customAlertForError(context, 'Invalid',
                "Some Error Occured while processing your request.");
            break;
          }
        case "0":
          {
            //#region Code
            bool oSuccess = oRes["Success"].toString() == "true";
            if (oSuccess == true) {
              var oUser = userVerificationResult.object;
              var oYearMasterID = oRes["YearMasterID"];
              if (oUser.UserID > 0) {
                try {

                  if (oYearMasterID != null) {
                    //#region for get Dashboard call
                    var oResult = await getStudentDashboardData(
                        oUser.UserID.toString(),
                        oYearMasterID != null ? oYearMasterID.toString() : "");

                    Map<String, dynamic> oStudentProfileData = oResult;
                    if (oStudentProfileData.isNotEmpty) {
                      if (oStudentProfileData.containsKey('Result')) //Login
                      {
                        var oFinalResult = oStudentProfileData["Result"];
                        //write Local storage
                        insertStudentFullDetail(oFinalResult);
                        setConstantValue();
                        dialog.dismiss();
                        Navigator.pushReplacementNamed(context, "dashboard");
                      } else {
                        dialog.dismiss();
                        showCustomToast(context, "Something went wrong.");
                      }
                    } else {
                      dialog.dismiss();
                      showCustomToast(context, "Something went wrong.");
                    }
                    //#endregion for get Dashboard call
                  } else {
                    //#region Branch Selection
                    dialog.dismiss();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BranchSelection()));
                    //#endregion
                  }
                } catch (e) {
                  print("Err:: 00" + e.toString());
                }
              } else {
                //#region Code
                dialog.dismiss();
                customAlertForError(context, 'Edusprint+',
                    userVerificationResult.responseMessge!);

                //Need to Call Logout method.
                //#endregion
              }
            }
            //#endregion Code
            break;
          }
        case "3":
          {
            //#region Code
            dialog.dismiss();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => FirstTimeChangePassword(
                          //Pass Data second widget
                          changePasswordModel: ChangePasswordModel(
                              userVerificationResult.object.UserID > 0
                                  ? userVerificationResult.object.UserID
                                  : 0,
                              userVerificationResult.object.UpdatedOn,
                              "ForcedPasswordChange",
                              "",
                              ""),
                        )));
            //#endregion Code
            break;
          }
        case "4":
          {
            //#region Code
            dialog.dismiss();
            customAlertForError(
                context, 'Invalid', userVerificationResult.responseMessge!);
            Navigator.pop(context);
            //#endregion Code
            break;
          }
        case "5":
          {
            //#region Code
            dialog.dismiss();
            customAlertForError(
                context, 'Invalid', userVerificationResult.responseMessge!);
            Navigator.pop(context);
            //#endregion Code
            break;
          }
        default:
          {
            dialog.dismiss();
            break;
          }
      }
    } catch (e) {
      print("Error: " + e.toString());
    }
  } else {
    customAlertForError(context, 'Invalid',
        "Some error occured while processing your request. Please contact to Administrator");
  }
}


