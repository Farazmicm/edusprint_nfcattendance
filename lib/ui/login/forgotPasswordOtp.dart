import 'dart:convert' as convert;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ndialog/ndialog.dart';
import 'package:nfcdemo/enum/enum.dart';
import 'package:nfcdemo/services/apiFunctions.dart';
import 'package:nfcdemo/ui/login/userLogin.dart';
import 'package:nfcdemo/utilities/utility.dart';
import 'package:nfcdemo/widgets/loginUI.dart';
import 'package:nfcdemo/widgets/widgets.dart';

import 'forgotPassword.dart';

class ForgotPasswordGenerateOTP extends StatefulWidget {
  const ForgotPasswordGenerateOTP({Key? key}) : super(key: key);

  @override
  _ForgotPasswordGenerateOTPState createState() =>
      _ForgotPasswordGenerateOTPState();
}

class _ForgotPasswordGenerateOTPState extends State<ForgotPasswordGenerateOTP> {
  final _generateOTPKey = GlobalKey<FormState>();
  var cntForUserName = TextEditingController();
  String schoolGroupName = "", imgUrl = "";

  @override
  void initState() {
    super.initState();
    setSchoolGroupData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginUI(
      height: .80,
      child: Form(
        key: _generateOTPKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
              child: Text(this.schoolGroupName,
                  style: Theme.of(context).textTheme.headline2),
            ),
            SizedBox(),
            CustomTextField(
              controller: cntForUserName,
              labelText: 'UserName',
              prefixIcon: Icon(
                Icons.account_circle,
              ),
              textInputType: TextInputType.text,
              validator: MultiValidator(
                  [RequiredValidator(errorText: "Please Enter User Name")]),
            ),
            SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomElevatedButton(
                  text: "Generate OTP",
                  width: size.width * .3,
                  onBtnPressed: () => generateOTP(),
                ),
                SizedBox(),
                CustomElevatedButton(
                  text: "Login",
                  width: size.width * .3,
                  onBtnPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => UserLogin()));
                  },
                )
              ],
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

  void generateOTP() async {
    ProgressDialog dialog = ProgressDialog(
      context,
      blur: 2,
      dialogTransitionType: DialogTransitionType.Shrink,
      message: CustomText(content: "Please wait..."),
      dialogStyle: DialogStyle(
        elevation: 5,
      ),
    );

    //Chek Internet Connection
    if (await Utility.isInternet()) {
      //Chek Form state is valid
      if (_generateOTPKey.currentState!.validate()) {
        dialog.show();
        //Call Web Api
        var oForgotPasswordResponse =
            await verificationCodePost(cntForUserName, false);
        dialog.dismiss();
        if (oForgotPasswordResponse.ResponseData != "") {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.INFO,
              animType: AnimType.SCALE,
              headerAnimationLoop: true,
              title: '',
              desc: oForgotPasswordResponse.ResponseData,
              btnCancelText: "No",
              btnCancelOnPress: () {},
              btnOkText: "Yes",
              btnOkOnPress: () {
                sendVerificationCode();
              },
              btnOkColor: Colors.blue)
            ..show();
        } else {
          customAlertForError(context, 'Invalid',
              oForgotPasswordResponse.ResponseMessage ?? "");
        }
      }
    } else {
      showCustomToast(context, null);
    }
  }

  void sendVerificationCode() async {
    {
      ProgressDialog dialog = ProgressDialog(
        context,
        blur: 2,
        dialogTransitionType: DialogTransitionType.Shrink,
        message: CustomText(content: "Please wait..."),
        dialogStyle: DialogStyle(
          elevation: 5,
        ),
      );
      dialog.show();
      var oVerificationResponse =
          await verificationCodePost(cntForUserName, true);
      if (oVerificationResponse.Success) {
        dialog.dismiss();
        showCustomToast(
            context, 'Verification code sent to you Please verify it');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ForgotPassword(userName: cntForUserName.text),
            ));
      } else {
        dialog.dismiss();
      }
    }
  }
}
