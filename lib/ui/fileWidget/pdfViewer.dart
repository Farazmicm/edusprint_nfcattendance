import 'package:flutter/material.dart';
import 'package:nfcdemo/utilities/constants.dart';
import 'package:nfcdemo/utilities/utility.dart';
import 'package:nfcdemo/widgets/layoutWidget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerForNetwork extends StatelessWidget {
  const PDFViewerForNetwork(
      {Key? key, required this.url, required this.appBarTitle})
      : super(key: key);

  final String url;
  final String appBarTitle;

  @override
  Widget build(BuildContext context) {
    //imageFileHostedPath + url;
    //print("File Url: " + (imageFileHostedPath + url));

    return LayoutWidget(
        appTitle: appBarTitle,
        child: SfPdfViewer.network(
          (imageFileHostedPath + url),
          enableDoubleTapZooming: true,
          onDocumentLoadFailed: (PdfDocumentLoadFailedDetails pd) {
            customAlertForError(context, 'Edusprint+', "File not available.");
          },
        ));
  }
}
