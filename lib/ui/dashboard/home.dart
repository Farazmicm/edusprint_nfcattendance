import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfcdemo/ui/userProfile/studentProfileDetail.dart';
import 'package:nfcdemo/utilities/utility.dart';
import 'package:nfcdemo/widgets/drawerWidget.dart';
import 'package:nfcdemo/widgets/loggedin_users.dart';
import 'package:nfcdemo/widgets/widgets.dart';

import '../../utilities/constants.dart';
import 'dashboard.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  static const List<Widget> _pages = <Widget>[
    Dashboard(),
    StudentProfileDetail(),
  ];

  static const List<Widget> _bottomTabPages = <Widget>[
    StudentProfileDetail(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  int _currentBottomBarIndex = 0;
  bool _showBottomBar = false;

  final _tabs = [
    Dashboard(),
    StudentProfileDetail(),
  ];

  Widget _changeUpperTab(upperTabIdx, isBottomBar) {
    setState(() {
      _showBottomBar = isBottomBar;
    });

    if (_showBottomBar) {
      return Scaffold(
        body: _bottomTabPages.elementAt(_currentBottomBarIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentBottomBarIndex,
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
          onTap: (index) {
            setState(() {
              _currentBottomBarIndex = index;
            });
          },
        ),
      );
    } else {
      return _pages.elementAt(upperTabIdx);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var theme = Theme.of(context);
    return SafeArea(
        top: true,
        right: true,
        bottom: true,
        left: true,
        maintainBottomViewPadding: true,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(double.maxFinite, 95),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: AppBar(
                    bottom: TabBar(
                      tabs: [
                        Tab(
                            child: CustomText(
                          content: 'Home',
                          style: GoogleFonts.lato(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                        Tab(
                            child: CustomText(
                          content: 'Profile',
                          style: GoogleFonts.lato(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                      ],
                    ),
                    title: CustomTextSingleLine(
                      content: schoolName,
                      style: GoogleFonts.lato(
                          color: theme.colorScheme.background,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    actions: [
                      ManageUserDetails(),
                      IconButton(
                          onPressed: () async {
                            await logOutConfirmation(context);
                          },
                          icon: Icon(Icons.logout))
                    ],
                  ),
                ),
              ),
            ),
            drawer: DrawerWidget(),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                _changeUpperTab(0, false),
                _changeUpperTab(1, true),
              ],
            ),
          ),
        ));
  }
}
