import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ndialog/ndialog.dart';
import 'package:nfcdemo/services/apiFunctions.dart';
import 'package:nfcdemo/ui/login/userLogin.dart';
import 'package:nfcdemo/utilities/utility.dart';
import 'package:nfcdemo/widgets/loginUI.dart';
import 'package:nfcdemo/widgets/widgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key, required this.userName}) : super(key: key);

  final String userName;

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _forgotPasswordStateKey = GlobalKey<FormState>();
  var cntForUserName = TextEditingController();
  var cntForNewPassWord = TextEditingController();
  var cntForConfirmPassWord = TextEditingController();
  var cntForOTP = TextEditingController();

  bool _isHidden = true;
  bool _isHiddenConfirmPass = true;

  @override
  void initState() {
    super.initState();
    cntForUserName.text = widget.userName;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginUI(
      height: 1.1,
      child: Form(
        key: _forgotPasswordStateKey,
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
              controller: cntForUserName,
              labelText: 'UserName',
              isreadOnly: true,
              prefixIcon: Icon(
                Icons.account_circle,
              ),
              textInputType: TextInputType.text,
              validator: MultiValidator(
                  [RequiredValidator(errorText: "Please Enter User Name")]),
            ),
            SizedBox(),
            CustomTextField(
              controller: cntForNewPassWord,
              labelText: 'Password',
              prefixIcon: Icon(
                Icons.lock,
              ),
              suffixIcon: IconButton(
                  icon: Icon(
                    _isHidden ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isHidden = !_isHidden;
                    });
                  }),
              textInputType: TextInputType.text,
              isPassword: _isHidden,
              validator: MultiValidator([
                RequiredValidator(errorText: "Please Enter New Password"),
              ]),
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
                    // Based on passwordVisible state choose the icon
                    _isHiddenConfirmPass
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
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
            CustomTextField(
              controller: cntForOTP,
              labelText: 'OTP',
              prefixIcon: Icon(
                Icons.phone,
              ),
              textInputType: TextInputType.number,
              validator: MultiValidator([
                RequiredValidator(errorText: "Please Enter OTP"),
              ]),
            ),
            SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomElevatedButton(
                  text: "Save",
                  width: size.width * .3,
                  onBtnPressed: () => forgotPassWord(),
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

  void forgotPassWord() async {
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
      if (_forgotPasswordStateKey.currentState!.validate()) {
        dialog.show();
        var oForgotPassWordResponse = await forgotPasswordPost(
            cntForUserName, cntForNewPassWord, cntForOTP);
        if (oForgotPassWordResponse.Success) {
          dialog.dismiss();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => UserLogin()));
          showCustomToast(
              context, oForgotPassWordResponse.ResponseMessage ?? "");
        } else {
          dialog.dismiss();
          customAlertForError(context, 'Invalid',
              oForgotPassWordResponse.ResponseMessage ?? "");
        }
      }
    } else {
      showCustomToast(context, null);
    }
  }
}
