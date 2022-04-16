import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfcdemo/widgets/widgets.dart';

import 'drawerWidget.dart';

class LayoutWidget extends StatelessWidget {
  final Widget? drawer;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget child;
  final String? appTitle;
  final Key? scaffKey;

  const LayoutWidget(
      {Key? key,
      this.appBar,
      this.drawer,
      this.bottomNavigationBar,
      this.appTitle,
      this.scaffKey,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var them = Theme.of(context);
    return SafeArea(
        top: true,
        right: true,
        bottom: true,
        left: true,
        maintainBottomViewPadding: true,
        child: Scaffold(
            key: scaffKey,
            appBar: appBar ??
                PreferredSize(
                  preferredSize: Size(double.infinity, kToolbarHeight),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: AppBar(
                        leading: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        title: CustomTextSingleLine(
                          content: appTitle ?? "",
                          style: GoogleFonts.lato(
                              color: them.colorScheme.background,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
            endDrawer: drawer ?? DrawerWidget(),
            bottomNavigationBar: bottomNavigationBar,
            body: child));
  }
}
