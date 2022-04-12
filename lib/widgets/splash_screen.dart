import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nfcdemo/ui/home/home.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SchoolGro()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Center(
              child: Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.cover,
          )),
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Center(child:
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text("Powered by MICM",style: TextStyle(fontSize: 16.0,wordSpacing: 1)),
                    ),
                  )
                ]),
          )
        ],
      ),
    );
  }
}
