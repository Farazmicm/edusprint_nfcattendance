
import 'package:flutter/material.dart';
import 'package:nfcdemo/ui/home/home.dart';
import 'package:nfcdemo/widgets/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  return MaterialPageRoute(builder: (context) {

    switch (settings.name) {
      case '/':
        return Splashscreen();
      default:
        return Home();
    }
  });
}