import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      textTheme: TextTheme(
          headline6: TextStyle(color: Colors.black87, fontSize: 14),
          caption: TextStyle(
            color: Colors.black54,
            fontSize: 13,
          )),
    );
  }
}
