import 'package:flutter/material.dart';
import 'package:nfcdemo/ui/dashboard/home.dart';
import 'package:nfcdemo/ui/userProfile/parentProfileDetail.dart';
import 'package:nfcdemo/ui/userProfile/studentProfileDetail.dart';
import 'package:nfcdemo/widgets/layoutWidget.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int _currentIndex = 0;
  static const List<Widget> _pages = <Widget>[
    StudentProfileDetail(),
    ParentProfileDetail(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
        return Future.value(false);
      },
      child: LayoutWidget(
          child: _pages.elementAt(_currentIndex),
          bottomNavigationBar: Container(
            height: 60,
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() => _currentIndex = index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded),
                  label: "Student Profile",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.supervisor_account_outlined),
                  label: "Parent Profile",
                )
              ],
            ),
          )),
    );
  }
}
