import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nfcdemo/widgets/widgets.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(content: "Edusprint+"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
      ),
      body: Center(
        child: CustomMessage(
          msg: "No Internet Available",
        ),
      ),
    );
  }
}
