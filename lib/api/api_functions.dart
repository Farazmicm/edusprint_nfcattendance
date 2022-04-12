import 'dart:convert' as convert;
import 'dart:io';

import 'package:nfcdemo/common/constants.dart';
import 'package:nfcdemo/common/utilities.dart';
import 'package:nfcdemo/models/school_group_login_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Map<String, String> headers = {
  'Content-type': 'application/x-www-form-urlencoded',
  'Accept': 'application/json',
};

//School Group code login
Future<SchoolGroupWiseLoginModel> schoolGroupShortCodeLogin(
    String schoolGroupShortName) async {
  try {
    String oUrl =
        'http://mobileapiv2.edusprint.in/Home/GetSchoolGroupDetails?schoolshortcode=${schoolGroupShortName.trim()}';

    var oResponse = await http.get(Uri.parse(oUrl)).then((http.Response response) {
      return SchoolGroupWiseLoginModel.fromJson(
          convert.jsonDecode(response.body));
    }).catchError((e) {
      print("schoolGroupShortCodeLogin: " + e.toString());
    });

    if (oResponse.ClientID > 0) {
      //if (await Utility.clearLocalStorage()) {
      //Set Global Variable
      ClientWEBURL = oResponse.ClientWEBURL ?? "";
      ClientShortCode = oResponse.ClientShortCode ?? "";

      //Write Local Storage
      await Utility.writeLocalStorage("SchoolGroupLoginResponse",convert.jsonEncode(oResponse));
      await Utility.writeLocalStorage("ClientWEBURL", ClientWEBURL);
      await Utility.writeLocalStorage("ClientShortCode", ClientShortCode);
      //}
    }
    return oResponse;
  } catch (e) {
    throw (e);
  }
}

//New Token
/*Future<NewTokenModel> getNewToken() async {
  try {
    String oUrl = ClientWEBURL +
        '/' +
        ClientShortCode +
        '/Mobile/GetNewToken?IMR=1&Cookies=IMR=1';
    oResponse = await http.get(Uri.parse(oUrl)).then((
        http.Response response,
        ) {
      return NewTokenModel.fromJson(convert.jsonDecode(response.body));
    }).catchError((e) {
      syncError("getNewToken", e);
    });

    Token = oResponse.ResponseData;
    await Utility.removeLocalStorageKey(localStorageKeyEnum.Token.toString());
    await Utility.writeLocalStorage(
        localStorageKeyEnum.Token.toString(), oResponse.ResponseData);
    return oResponse;
  } catch (e) {
    throw (e);
  }
}*/
