import 'package:flutter/material.dart';
import 'package:nfcdemo/providers/connectivityProvider.dart';
import 'package:nfcdemo/ui/dashboard/home.dart';
import 'package:nfcdemo/ui/login/add_new_student.dart';
import 'package:nfcdemo/ui/login/schoolGroupWiseLogin.dart';
import 'package:nfcdemo/ui/login/userLogin.dart';
import 'package:nfcdemo/ui/screens/webViewLoading.dart';
import 'package:nfcdemo/ui/splashscreen/splashscreen.dart';
import 'package:nfcdemo/widgets/nointernet_page.dart';
import 'package:provider/provider.dart';

import '../ui/fileWidget/pdfViewer.dart';
import '../ui/login/changeYear.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var oArguments = settings.arguments.toString().split('###');

  return MaterialPageRoute(builder: (context) {
    var isOnline = Provider.of<ConnectivityProvider>(context).isOnline;
    if (!isOnline) {
      return NoInternetPage();
    }
    switch (settings.name) {
      case '/':
        return Splashscreen();
      case 'schoolgrouplogin':
        return SchoolGroupWiseLogin();
      case 'addstudent':
        return NewStudentAdd();
      case 'userlogin':
        return UserLogin();
      case 'dashboard':
        return Home();
      case 'changeyear':
        return ChangeYear(appBarTitle: settings.arguments.toString());
      /*case 'webviewcall':
        return WebViewLoading(
          webViewUrl: oArguments.first,
          title: oArguments.last,
        );*/
      case 'pdfviewer':
        return PDFViewerForNetwork(
          url: oArguments.first,
          appBarTitle: oArguments.last,
        );
      default:
        return Home();
    }
  });
}
