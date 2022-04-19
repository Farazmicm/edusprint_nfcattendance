import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nfcdemo/database_mng/repository/userdetails_repository.dart';
import 'package:nfcdemo/ui/dashboard/home.dart';
import 'package:nfcdemo/utilities/constants.dart';
import 'package:nfcdemo/widgets/loggedin_users.dart';
import 'package:nfc_manager/nfc_manager.dart';
import '../../widgets/widgets.dart';
import '../login/schoolGroupWiseLogin.dart';
import 'package:nfcdemo/utilities/utility.dart';
import 'package:flutter/services.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:nfcdemo/services/apiFunctions.dart';
import 'package:nfcdemo/database_mng/repository/attendance_userprofile_repository.dart';

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
    try{
      if(await NfcManager.instance.isAvailable())
      {
        Timer(const Duration(seconds: 1), () async {
          await AttendanceUserProfileRepository.getAttendanceUserProfiles().then((value) {
            if(value.length > 0){
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
            }else{
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SchoolGroupWiseLogin()));
            }
          });

          /*if (UserID == "") {

            *//*await UserDetailsRepository.getUsers().then((value) {
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
        });*//*
          } else {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));
          }*/
        });
      }else{
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            headerAnimationLoop: true,
            title: 'Error',
            desc: 'Your Device not Support NFC Feature.',
            btnOkOnPress: () { SystemNavigator.pop(); },
            btnOkColor: Colors.red)
          ..show();
      }
    }catch(e){
      print("processStartupLogic: " + e.toString());
    }
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
