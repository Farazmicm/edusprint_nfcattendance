import 'dart:convert' as convert;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:nfcdemo/database_mng/repository/userdetails_repository.dart';
import 'package:nfcdemo/enum/enum.dart';
import 'package:nfcdemo/services/apiFunctions.dart';
import 'package:nfcdemo/utilities/constants.dart';
import 'package:nfcdemo/utilities/deviceinfo.dart';
import 'package:nfcdemo/widgets/loggedin_users.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/widgets.dart';

class Utility {
  //Check Internet Connection
  static Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi)
      return true;
    else
      return false;
  }

  static Future<bool> writeLocalStorage(
      String localStorageKey, String value) async {
    late SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    return localStorage.setString(localStorageKey, value);
  }

  static Future<String> readLocalStorage(String localStorageKey) async {
    late SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    return localStorage.getString(localStorageKey) ?? "";
  }

  static Future<bool> removeLocalStorageKey(String localStorageKey) async {
    var localStorage = await SharedPreferences.getInstance();
    return localStorage.remove(localStorageKey);
  }

  static Future<bool> clearLocalStorage() async {
    late SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    return localStorage.clear();
  }
}

Future<ToastFuture> showCustomToast(BuildContext context, String? msg) async {
  return showToast(
    msg ?? 'Please check your internet connection and try again',
    context: context,
    axis: Axis.horizontal,
    alignment: Alignment.center,
    position: StyledToastPosition.top,
    toastHorizontalMargin: 20,
    fullWidth: true,
    duration: Duration(seconds: 3),
  );
}

Future<AwesomeDialog> customAlertForError(
    BuildContext context, String title, String desc) async {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.SCALE,
      headerAnimationLoop: true,
      title: title,
      desc: desc,
      btnOkOnPress: () {},
      btnOkColor: Colors.red)
    ..show();
}

Future<ProgressDialog> customProgressDialog(
    BuildContext context, String msg) async {
  return ProgressDialog(
    context,
    blur: 2,
    dialogTransitionType: DialogTransitionType.LeftToRight,
    message: CustomText(content: msg),
    dialogStyle: DialogStyle(
      elevation: 5,
    ),
  );
}

String shortDate(String dateTime, String dFormat) {
  final dateFormat = new DateFormat(dFormat);
  return dateFormat.format(DateTime.parse(dateTime));
}

Future<dynamic> setDeviceInformation() async {
  try {
    var oDeviceInfo = await DeviceInfo().initPlatformState();
    if (oDeviceInfo != null) {
      await Utility.removeLocalStorageKey(
          localStorageKeyEnum.DeviceInformation.toString());

      await Utility.writeLocalStorage(
          localStorageKeyEnum.DeviceInformation.toString(),
          convert.jsonEncode(oDeviceInfo));
    }
    return oDeviceInfo;
  } catch (e) {
    print("setDeviceInformation: " + e.toString());
  }
}

Future<bool> logOutFromDevice(BuildContext buildContext) async {
  try {
    ProgressDialog dialog = ProgressDialog(
      buildContext,
      blur: 2,
      dialogTransitionType: DialogTransitionType.Shrink,
      message: CustomText(content: "Please wait..."),
      dialogStyle: DialogStyle(
        elevation: 5,
      ),
    );
    dialog.show();
    var oCurrentUser = await UserDetailsRepository.getCurrentUserDetails();

    return await logOutUser().then((value) async {
      if (value) {
        await UserDetailsRepository.deleteUserDetails(oCurrentUser.UserID)
            .then((value) async {
          await UserDetailsRepository.deleteUser(oCurrentUser.UserID)
              .then((value) async {
            await Utility.clearLocalStorage()
                .then((value) => {clearGlobalData()});
          });
        });
        dialog.dismiss();
      } else {
        dialog.dismiss();
        showCustomToast(buildContext, "Something went wrong.");
      }
      return value;
    });
  } catch (e) {
    print("logOutFromDevice: " + e.toString());
    return false;
  }
}

Future<void> logOutConfirmation(BuildContext buildContext) async {
  try {
    AwesomeDialog(
        context: buildContext,
        dialogType: DialogType.QUESTION,
        animType: AnimType.SCALE,
        headerAnimationLoop: true,
        title: 'Sign out',
        desc: 'Are you sure, you want to sign out?',
        btnCancelText: "Cancel",
        btnCancelOnPress: () {},
        btnCancelIcon: Icons.close,
        btnOkText: "Sign out",
        btnOkOnPress: () async {
          await logOutFromDevice(buildContext).then((value) async {
            if (value) {
              await UserDetailsRepository.getUsers().then((value) {
                if (value.length > 0) {
                  showModalBottomSheet<void>(
                      context: buildContext,
                      backgroundColor: Colors.white,
                      builder: (context) => UserDetailsBody(
                            appBarTitle: "Select Student",
                          ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.0)),
                      ));
                } else {
                  Navigator.pushReplacementNamed(
                      buildContext, "schoolgrouplogin");
                }
              });
            }
          });
        },
        btnOkIcon: Icons.logout,
        dismissOnTouchOutside: false,
        btnOkColor: Colors.blue)
      ..show();
  } catch (e) {
    print("logOutConfirmation: " + e.toString());
  }
}

void clearGlobalData() {
  ClientWEBURL = "";
  ClientShortCode = "";
  Token = "";
  UserID = "";
  yearMasterID = "";
  studentYearID = "";
  imageFileHostedPath = "";
  schoolGroupID = "";
  schoolID = "";
  sectionMasterID = "";
  classMasterID = "";
  divisionMasterID = "";
  houseID = "";
  genderID = "";
}
