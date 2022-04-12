

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:getwidget/getwidget.dart';
import 'package:nfcdemo/api/api_functions.dart';
import 'package:nfcdemo/common/utilities.dart';
import 'package:nfcdemo/ui/home/home.dart';


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
  late bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _schoolGroupFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Image.asset("assets/images/logo.png",
                height: 58,
                width: 58,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(),
            Text('Edusprint+',
                textScaleFactor: 1.0,
                style: Theme.of(context).textTheme.headline2),
            SizedBox(),
            CustomTextField(
              labelText: 'SchoolGroup Code',
              prefixIcon: Icon(
                Icons.apartment_rounded,
              ),
              textInputType: TextInputType.text,
              validator: MultiValidator([
                RequiredValidator(errorText: "Please Enter School Group Code"),
              ]),
              controller: cntSchoolGroupCode,
            ),
            SizedBox(),
            GFButton(
              onPressed: ()=> schoolLogin(),
              text: "Proceed",
              icon: Icon(Icons.login),
              shape: GFButtonShape.pills,
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }

  void schoolLogin() async {
    try {

      //Chek Internet Connection
      if (await Utility.isInternet()) {
        //Chek Form state is valid
        if (_schoolGroupFormKey.currentState!.validate()) {
          setState(() {
            _isLoading = true;
          });
          //Call Web Api
          var schoolGroupResponse =
          await schoolGroupShortCodeLogin(cntSchoolGroupCode.text);
          //Valid School Group code
          if (schoolGroupResponse.ClientID > 0) {
            //Generate token
            setState(() {
              _isLoading = false;
            });

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ));

          } else {
            setState(() {
              _isLoading = false;
            });
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