import 'dart:convert' as convert;

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfcdemo/enum/enum.dart';
import 'package:nfcdemo/models/VWStudentFullDetailNullable.dart';
import 'package:nfcdemo/services/apiFunctions.dart';
import 'package:nfcdemo/utilities/utility.dart';
import 'package:nfcdemo/widgets/widgets.dart';

import '../../utilities/constants.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  //late WebViewController webViewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return SingleChildScrollView(
            controller: ScrollController(),
            padding: EdgeInsets.all(13),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [Container(child: Text('Welcome'),)],
            ),
          );
  }
}
