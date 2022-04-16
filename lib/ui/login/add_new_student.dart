import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nfcdemo/ui/login/schoolGroupWiseLogin.dart';
import 'package:nfcdemo/widgets/loginUI.dart';

class NewStudentAdd extends StatefulWidget {
  const NewStudentAdd({Key? key}) : super(key: key);

  @override
  _NewStudentAddState createState() => _NewStudentAddState();
}

class _NewStudentAddState extends State<NewStudentAdd> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginUI(
      height: .90,
      child: SchoolGroupWiseLogin(),
      isUseWithAppbar: true,
    );
  }
}
