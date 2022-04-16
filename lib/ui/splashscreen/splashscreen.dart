import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nfcdemo/database_mng/repository/userdetails_repository.dart';
import 'package:nfcdemo/ui/dashboard/home.dart';
import 'package:nfcdemo/utilities/constants.dart';
import 'package:nfcdemo/widgets/loggedin_users.dart';

import '../../widgets/widgets.dart';
import '../login/schoolGroupWiseLogin.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    processStartupLogic();
  }

  void processStartupLogic() async {
    Timer(const Duration(seconds: 1), () async {
      if (UserID == "") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SchoolGroupWiseLogin()));
        /*await UserDetailsRepository.getUsers().then((value) {
          if (value.isNotEmpty) {
            showBottomSheetPage<void>(
                context: context,
                body: UserDetailsBody(
                  appBarTitle: "Select Student to Proceed",
                ),
                backgroundcolor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0)),
                ));
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => SchoolGroupWiseLogin()));
          }
        });*/
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: ImageWithAsset(path: 'images/logo.png'),
      ),
    );
  }
}
