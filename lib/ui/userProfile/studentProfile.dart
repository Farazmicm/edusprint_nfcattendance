import 'package:flutter/material.dart';
import 'package:nfcdemo/ui/userProfile/studentProfileDetail.dart';
import 'package:nfcdemo/widgets/layoutWidget.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({Key? key, this.appBarTitle}) : super(key: key);

  final String? appBarTitle;

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      appTitle: appBarTitle ?? "Student Profile",
      child: StudentProfileDetail(),
    );
  }
}
