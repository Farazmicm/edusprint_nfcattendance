import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ndialog/ndialog.dart';
import 'package:nfcdemo/models/changePasswordModel.dart';
import 'package:nfcdemo/services/apiFunctions.dart';
import 'package:nfcdemo/ui/login/userLogin.dart';
import 'package:nfcdemo/utilities/utility.dart';
import 'package:nfcdemo/widgets/loginUI.dart';
import 'package:nfcdemo/widgets/widgets.dart';

class FirstTimeChangePassword extends StatefulWidget {
  const FirstTimeChangePassword({Key? key, required this.changePasswordModel})
      : super(key: key);

  final ChangePasswordModel changePasswordModel;

  @override
  _FirstTimeChangePasswordState createState() =>
      _FirstTimeChangePasswordState();
}

class _FirstTimeChangePasswordState extends State<FirstTimeChangePassword> {
  final changePassWorKey = GlobalKey<FormState>();
  var cntForCurrentPassword = TextEditingController();
  var cntForNewPassWord = TextEditingController();
  var cntForConfirmPassWord = TextEditingController();
  var cntForOTP = TextEditingController();

  bool _isHidden = true;
  bool _isHiddenConfirmPass = true;
  bool _isHiddenVerificationCode = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginUI(
      height: 1.2,
      child: Form(
        key: changePassWorKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(),
            Center(
              child: Text("Change Password",
                  style: Theme.of(context).textTheme.headline2),
            ),
            SizedBox(),
            CustomTextField(
              controller: cntForCurrentPassword,
              labelText: 'Current Password',
              isPassword: _isHiddenVerificationCode,
              prefixIcon: Icon(
                Icons.lock,
              ),
              suffixIcon: IconButton(
                icon: Icon(_isHiddenVerificationCode
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isHiddenVerificationCode = !_isHiddenVerificationCode;
                  });
                },
              ),
              textInputType: TextInputType.text,
              validator: MultiValidator([
                RequiredValidator(errorText: "Please Enter Verification Code")
              ]),
            ),
            SizedBox(),
            CustomTextField(
              controller: cntForNewPassWord,
              labelText: 'New Password',
              prefixIcon: Icon(
                Icons.lock,
              ),
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
                  [RequiredValidator(errorText: "Please Enter New Password")]),
            ),
            SizedBox(),
            CustomTextField(
              controller: cntForConfirmPassWord,
              labelText: 'Confirm Password',
              prefixIcon: Icon(
                Icons.lock,
              ),
              suffixIcon: IconButton(
                  icon: Icon(
                    _isHiddenConfirmPass
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isHiddenConfirmPass = !_isHiddenConfirmPass;
                    });
                  }),
              textInputType: TextInputType.text,
              isPassword: _isHiddenConfirmPass,
              validator: (val) =>
                  MatchValidator(errorText: "Passwords do not match")
                      .validateMatch(
                          cntForConfirmPassWord.text, cntForNewPassWord.text),
            ),
            SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomElevatedButton(
                  text: "Save",
                  width: size.width * .3,
                  onBtnPressed: () => changePassWord(),
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

  void changePassWord() async {
    ProgressDialog dialog = ProgressDialog(
      context,
      blur: 2,
      dialogTransitionType: DialogTransitionType.Shrink,
      message: CustomText(content: "Please wait..."),
      dialogStyle: DialogStyle(
        elevation: 5,
      ),
    );

    if (await Utility.isInternet()) {
      if (changePassWorKey.currentState!.validate()) {
        widget.changePasswordModel.OldPassword = cntForCurrentPassword.text;
        widget.changePasswordModel.NewPassword = cntForNewPassWord.text;

        dialog.show();

        var oResponse = await changePasswordPost(widget.changePasswordModel);
        if (oResponse.IsSuccess) {
          dialog.dismiss();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => UserLogin()));
          showCustomToast(context, oResponse.ResponseMessage);
        } else {
          dialog.dismiss();
          customAlertForError(context, 'Invalid', oResponse.ResponseMessage);
        }
      }
    } else {
      showCustomToast(context, null);
    }
  }
}
