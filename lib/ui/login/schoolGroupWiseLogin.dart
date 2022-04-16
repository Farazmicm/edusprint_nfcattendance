import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ndialog/ndialog.dart';
import 'package:nfcdemo/services/apiFunctions.dart';
import 'package:nfcdemo/ui/login/userLogin.dart';
import 'package:nfcdemo/utilities/utility.dart';
import 'package:nfcdemo/widgets/loginUI.dart';
import 'package:nfcdemo/widgets/widgets.dart';

class SchoolGroupWiseLogin extends StatefulWidget {
  bool? isAddStudents;

  SchoolGroupWiseLogin({Key? key, this.isAddStudents = false})
      : super(key: key);

  @override
  _SchoolGroupWiseLoginState createState() => _SchoolGroupWiseLoginState();
}

class _SchoolGroupWiseLoginState extends State<SchoolGroupWiseLogin> {
  final _schoolGroupFormKey = GlobalKey<FormState>();
  var cntSchoolGroupCode = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginUI(
      height: .90,
      child: Form(
        key: _schoolGroupFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
            Text('Edusprint Attendance',
                textScaleFactor: 1.0,
                style: Theme.of(context).textTheme.headline2),
            SizedBox(),
            CustomTextField(
              labelText: 'School Group Code',
              prefixIcon: Icon(
                Icons.apartment_rounded,
              ),
              textInputType: TextInputType.text,
              validator: MultiValidator([
                RequiredValidator(errorText: "Please Enter School Group Code")
              ]),
              controller: cntSchoolGroupCode,
            ),
            SizedBox(),
            CustomElevatedButton(
              onBtnPressed: () => schoolLogin(),
              text: "Proceed",
              width: size.width * .5,
            ),
            SizedBox(),
            CopyRightText(),
            SizedBox(),
          ],
        ),
      ),
    );
  }

  void schoolLogin() async {
    try {
      ProgressDialog dialog = ProgressDialog(context,
          blur: 2,
          dialogTransitionType: DialogTransitionType.Shrink,
          message: CustomText(content: "Please wait.."),
          dialogStyle: DialogStyle(
            elevation: 5,
          ),
          dismissable: false);

      //Chek Internet Connection
      if (await Utility.isInternet()) {
        //Chek Form state is valid
        if (_schoolGroupFormKey.currentState!.validate()) {
          dialog.show();
          //Call Web Api
          var schoolGroupResponse =
              await schoolGroupShortCodeLogin(cntSchoolGroupCode.text);
          //Valid School Group code
          if (schoolGroupResponse.ClientID > 0) {
            //Generate token
            getNewToken();
            dialog.dismiss();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserLogin(),
                  ));
          } else {
            dialog.dismiss();
            customAlertForError(
                context, 'Invalid', 'Invalid School Group code !');
          }
        }
      } else {
        showCustomToast(context, null);
      }
    } catch (ex) {}
  }
}
