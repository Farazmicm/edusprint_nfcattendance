import 'dart:convert' as convert;

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ndialog/ndialog.dart';
import 'package:nfcdemo/enum/enum.dart';
import 'package:nfcdemo/models/models.dart';
import 'package:nfcdemo/services/apiFunctions.dart';
import 'package:nfcdemo/ui/login/schoolGroupWiseLogin.dart';
import 'package:nfcdemo/utilities/common.dart';
import 'package:nfcdemo/utilities/constants.dart';
import 'package:nfcdemo/utilities/utility.dart';
import 'package:nfcdemo/widgets/loginUI.dart';
import 'package:nfcdemo/widgets/widgets.dart';

import 'forgotPasswordOtp.dart';

class UserLogin extends StatefulWidget {
  bool? hideLinks;

  UserLogin({Key? key, this.hideLinks = false}) : super(key: key);

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final userLoginKey = GlobalKey<FormState>();
  var cntForUserName = TextEditingController();
  var cntForPassWord = TextEditingController();
  String schoolGroupName = "", imgUrl = "";
  bool _isHidden = true;

  @override
  void initState() {
    setSchoolGroupData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginUI(
      height: 1.1,
      child: Form(
        key: userLoginKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ImageWithAsset(
                path: 'images/logo.png',
                height: 58,
                width: 58,
                boxFit: BoxFit.fill,
              ),
            ),
            SizedBox(),
            Center(
              child: Text(
                this.schoolGroupName,
                textScaleFactor: 1.0,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            SizedBox(),
            CustomTextField(
              controller: cntForUserName,
              hintText: 'UserName',
              prefixIcon: Icon(Icons.account_circle),
              textInputType: TextInputType.text,
              validator: MultiValidator(
                  [RequiredValidator(errorText: "Please Enter User Name")]),
            ),
            SizedBox(),
            CustomTextField(
              controller: cntForPassWord,
              hintText: 'Password',
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _isHidden ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _isHidden = !_isHidden;
                    });
                  }),
              textInputType: TextInputType.text,
              isPassword: _isHidden,
              validator: MultiValidator(
                  [RequiredValidator(errorText: "Please Enter Password")]),
            ),
            SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomElevatedButton(
                  text: "Sign in",
                  width: size.width * .3,
                  onBtnPressed: () => userSignIn(),
                ),
                (widget.hideLinks != null && widget.hideLinks == false)
                    ? RichText(
                        text: TextSpan(
                          text: 'Forget Password ?',
                          style: Theme.of(context).textTheme.headline3,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordGenerateOTP()));
                            },
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            SizedBox(),
            RichText(
              strutStyle: StrutStyle(),
              text: TextSpan(
                text: 'Change School Group Code',
                style: Theme.of(context).textTheme.headline3,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SchoolGroupWiseLogin()));
                  },
              ),
            ),
            SizedBox(),
            CopyRightText(),
            SizedBox(),
          ],
        ),
      ),
    );
  }

  void setSchoolGroupData() async {
    var schoolGroupData = await Utility.readLocalStorage(
        localStorageKeyEnum.SchoolGroupLoginResponse.toString());
    var objSchoolGroupData = convert.jsonDecode(schoolGroupData);
    setState(() {
      this.schoolGroupName = objSchoolGroupData['ClientName'];
    });
  }

  void userSignIn() async {
    try {
      ProgressDialog dialog = ProgressDialog(context,
          blur: 2,
          dialogTransitionType: DialogTransitionType.Shrink,
          message: CustomText(content: "Please wait..."),
          dialogStyle: DialogStyle(
            elevation: 5,
          ),
          dismissable: false);

      //Chek Internet Connection
      if (await Utility.isInternet()) {
        if (userLoginKey.currentState!.validate()) {
          dialog.show();
          //Api Call
          var oUserName = cntForUserName.text;
          var oPassword = cntForPassWord.text;
          Map<String, dynamic> oRes =
              await userSignInPostNew(oUserName, oPassword);
          if (oRes.isNotEmpty) {
            print("Login Response: " + convert.jsonEncode(oRes));

            var oUser = User.fromJson(oRes["User"]);
            oUser.ExUserName = oUserName;
            oUser.Password = oPassword;
            oUser.ExSchoolGroupCode = ClientShortCode;
            /*await verifyUser(oRes, oUser).then((value) async {
              await processUserLogin(value);
            });*/
          } else {
            dialog.dismiss();
          }
        }
      } else {
        dialog.dismiss();
        showCustomToast(context, null);
      }
    } catch (ex) {
      showCustomToast(context, ex.toString());
    }
  }
}

/*try {
              if (oStatusCode != null) {
                switch (oStatusCode.toString()) {
                  case "3": //First time Login (Message: Please login using browser and change your password first.)
                    {
                      //#region Code First Time change password
                      var oUser = User.fromJson(oRes["User"]);

                      await Utility.writeLocalStorage("UserName", oUserName);
                      await Utility.writeLocalStorage("Password", oPassword);

                      dialog.dismiss();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FirstTimeChangePassword(
                                    //Pass Data second widget
                                    changePasswordModel: ChangePasswordModel(
                                        oUser.UserID > 0 ? oUser.UserID : 0,
                                        oUser.UpdatedOn,
                                        "ForcedPasswordChange",
                                        "",
                                        ""),
                                  )));
                      //#endregion
                      break;
                    }
                  case "4": //Password Is Wrong (Message: Password Is Invalid.) | Username not Exist (Message: Username Does Not Exist.)
                    {
                      //#region Code Invalid
                      dialog.dismiss();
                      customAlertForError(context, 'Invalid', oResponseMessage);

                      //#endregion
                      break;
                    }
                  case "5": //Student Deactivate (Message: Student Deactivated)
                    {
                      //#region Code Deactivate
                      dialog.dismiss();
                      customAlertForError(context, 'Invalid', oResponseMessage);

                      //Need to Call Logout method.
                      //#endregion
                      break;
                    }
                  case "0": //No Error / Branch Year Selection (If SchoolId and YearMaster Id not received from setting)
                    {
                      //#region Code
                      bool oSuccess = oRes["Success"].toString() == "true";
                      if (oSuccess == true) {
                        await Utility.writeLocalStorage("UserName", oUserName);
                        await Utility.writeLocalStorage("Password", oPassword);

                        var oUser = User.fromJson(oRes["User"]);
                        var oYearMasterID = oRes["YearMasterID"];
                        if (oUser.UserID > 0) {
                          try {
                            //#region for UserList
                            List<Students> listUserProfile =
                                List.empty(growable: true);
                            listUserProfile
                                .add(Students.fromJson(oRes["UserProfile"]));
                            Utility.removeLocalStorageKey(
                                localStorageKeyEnum.Students.toString());
                            Utility.writeLocalStorage(
                                localStorageKeyEnum.Students.toString(),
                                convert.jsonEncode(listUserProfile));
                            //#endregion for userList

                            //#region for list od year
                            var oStudentsYears = await getStudentYears(
                                oUser.UserID.toString());
                            var lstStudentYears = List.from(oStudentsYears)
                                .map((e) => StudentYears.fromJson(e))
                                .toList();
                            Utility.removeLocalStorageKey(
                                localStorageKeyEnum.StudentYears
                                    .toString());
                            Utility.writeLocalStorage(
                                localStorageKeyEnum.StudentYears.toString(),
                                convert.jsonEncode(lstStudentYears));
                            //#endregion for list od year

                            if(oYearMasterID != null){
                              //#region for get Dashboard call
                              var oResult = await getStudentDashboardData(
                                  oUser.UserID.toString(),
                                  oYearMasterID != null
                                      ? oYearMasterID.toString()
                                      : "");

                              Map<String, dynamic> oStudentProfileData = oResult;
                              if (oStudentProfileData.isNotEmpty) {
                                if (oStudentProfileData
                                    .containsKey('Result')) //Login
                                    {
                                  var oFinalResult = oStudentProfileData["Result"];
                                  //write Local storage
                                  insertStudentFullDetail(oFinalResult);
                                  setConstantValue();
                                  dialog.dismiss();
                                  Navigator.pushReplacementNamed(context,"dashboard");
                                }else{
                                  dialog.dismiss();
                                  showCustomToast(context, "Something went wrong.");
                                }
                              }else{
                                dialog.dismiss();
                                showCustomToast(context, "Something went wrong.");
                              }
                              //#endregion for get Dashboard call
                            }else{
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
                          customAlertForError(
                              context, 'Edusprint+', oResponseMessage);

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
              }
            } catch (e) {
              print("Errrrror:: " + e.toString());
            }*/
