import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ndialog/ndialog.dart';
import 'package:nfcdemo/models/changePasswordModel.dart';
import 'package:nfcdemo/services/apiFunctions.dart';
import 'package:nfcdemo/ui/dashboard/home.dart';
import 'package:nfcdemo/utilities/constants.dart';
import 'package:nfcdemo/utilities/utility.dart';
import 'package:nfcdemo/widgets/loginUI.dart';
import 'package:nfcdemo/widgets/widgets.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final changePasswordKey = GlobalKey<FormState>();
  late ChangePasswordModel changePasswordModel;
  var cntForOldPassword = TextEditingController();
  var cntForNewPassWord = TextEditingController();
  var cntForConfirmPassWord = TextEditingController();

  bool _isHidden = true;
  bool _isHiddenConfirmPass = true;
  bool _isHiddenOldPass = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginUI(
      height: .9,
      child: Form(
        key: changePasswordKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(),
            Center(
              child: Text(
                "Change Password",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            SizedBox(),
            CustomTextField(
              controller: cntForOldPassword,
              labelText: 'Old Password',
              prefixIcon: Icon(
                Icons.lock,
              ),
              suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _isHiddenOldPass ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _isHiddenOldPass = !_isHiddenOldPass;
                    });
                  }),
              textInputType: TextInputType.text,
              isPassword: _isHiddenOldPass,
              validator: MultiValidator(
                  [RequiredValidator(errorText: "Please Enter Old Password")]),
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
              hintText: 'Confirm Password',
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black54,
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
                  text: "Clear",
                  width: size.width * .3,
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  onBtnPressed: () {
                    setState(() {
                      cntForOldPassword.text = "";
                      cntForNewPassWord.text = "";
                      cntForConfirmPassWord.text = "";
                    });
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
    try {
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
        if (changePasswordKey.currentState!.validate()) {
          dialog.show();
          var oResponse = await changePasswordPost(changePasswordModel =
              new ChangePasswordModel(int.parse(UserID), null, "ActionName",
                  cntForOldPassword.text, cntForNewPassWord.text));

          if (oResponse.IsSuccess) {
            dialog.dismiss();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));
            //  ShowCustomToast(context, oResponse.ResponseMessage);
          } else {
            dialog.dismiss();
            customAlertForError(context, 'Invalid', oResponse.ResponseMessage);
          }
        }
      } else {
        showCustomToast(context, null);
      }
    } catch (e) {
      print("Error");
      await syncError("changePassWord", e);
    }
  }
}
