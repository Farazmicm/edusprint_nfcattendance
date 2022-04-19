/*
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:nfcdemo/widgets/layoutWidget.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../widgets/widgets.dart';

class WebViewLoading extends StatefulWidget {
  const WebViewLoading(
      {Key? key, required this.title, required this.webViewUrl})
      : super(key: key);

  final String webViewUrl;
  final String title;

  @override
  _WebViewLoadingState createState() => _WebViewLoadingState();
}

class _WebViewLoadingState extends State<WebViewLoading> {
  @override
  Widget build(BuildContext context) {
    ProgressDialog dialog = ProgressDialog(context,
        blur: 2,
        dialogTransitionType: DialogTransitionType.Shrink,
        message: CustomText(content: "Please wait.."),
        dialogStyle: DialogStyle(
          elevation: 1,
        ),
        dismissable: false);
    return LayoutWidget(
        appTitle: widget.title,
        child: WebView(
          onPageStarted: (value) => {dialog.show()},
          onPageFinished: (value) => {dialog.dismiss()},
          onProgress: (value) => {dialog.show()},
          zoomEnabled: true,
          gestureNavigationEnabled: true,
          allowsInlineMediaPlayback: true,
          initialUrl: widget.webViewUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
*/
