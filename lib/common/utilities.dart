import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:nfcdemo/common/deviceinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as convert;

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
    msg ?? 'Some error occured, please try after sometime.',
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


String shortDate(String dateTime,String dFormat) {
  final dateFormat = new DateFormat(dFormat);
  return dateFormat.format(DateTime.parse(dateTime));
}



Future<dynamic> setDeviceInformation() async{
  try{
    var oDeviceInfo = await DeviceInfo().initPlatformState();
    print("oDeviceInfo: "+convert.jsonEncode(oDeviceInfo));
    if(oDeviceInfo != null){
      await Utility.removeLocalStorageKey("DeviceInformation");

      await Utility.writeLocalStorage("DeviceInformation",convert.jsonEncode(oDeviceInfo));
    }
    return oDeviceInfo;
  }catch(e){
    print("setDeviceInformation: " + e.toString());
  }

}
