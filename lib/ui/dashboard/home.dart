import 'dart:ui';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfcdemo/utilities/utility.dart';
import 'package:nfcdemo/widgets/drawerWidget.dart';
import 'package:nfcdemo/widgets/loggedin_users.dart';
import 'package:nfcdemo/widgets/widgets.dart';
import 'attendance_userdetails_page.dart';

import '../../utilities/constants.dart';
import 'dashboard.dart';
import 'package:nfc_manager/nfc_manager.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);
    return SafeArea(
        top: true,
        right: true,
        bottom: true,
        left: true,
        maintainBottomViewPadding: true,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: CustomTextSingleLine(
                content: "Home",
                style: GoogleFonts.lato(
                    color: theme.colorScheme.background,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: FutureBuilder<bool>(
                future: NfcManager.instance.isAvailable(),
                initialData: true,
                builder: (context, ss) => ss.data != true
                    ? Center(child: Text('This Device Not Supports NFC.'))
                    : Flex(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  direction: Axis.vertical,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.all(4),
                        constraints: BoxConstraints.expand(),
                        decoration: BoxDecoration(border: Border.all()),
                        child: SingleChildScrollView(
                          child: ValueListenableBuilder<dynamic>(
                            valueListenable: result,
                            builder: (context, value, _) =>
                                Text('${value ?? ''}'),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: GridView.count(
                        padding: EdgeInsets.all(4),
                        crossAxisCount: 2,
                        childAspectRatio: 4,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        children: [
                          ElevatedButton(
                              child: Text('Tag Read'), onPressed: _tagRead),
                          ElevatedButton(
                              child: Text('Ndef Write'),
                              onPressed: _ndefWrite),
                          ElevatedButton(
                              child: Text('Ndef Write Lock'),
                              onPressed: _ndefWriteLock),
                        ],
                      ),
                    ),
                    //AttendanceUserDetailsPage()
                  ],
                ),
              ),
            ),
          ),
        ));//AttendanceUserDetailsPage()
  }

  void _tagRead() {
    try{
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        result.value = tag.data;
        NfcManager.instance.stopSession();
      });
    }catch(e){
      print("_tagRead: " + e.toString());
    }

  }

  void _ndefWrite() {
    try{
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        var ndef = Ndef.from(tag);
        if (ndef == null || !ndef.isWritable) {
          result.value = 'Tag is not ndef writable';
          NfcManager.instance.stopSession(errorMessage: result.value);
          return;
        }

        NdefMessage message = NdefMessage([
          NdefRecord.createText('Hello World!'),
          NdefRecord.createUri(Uri.parse('https://flutter.dev')),
          NdefRecord.createMime(
              'text/plain', Uint8List.fromList('Hello'.codeUnits)),
          NdefRecord.createExternal(
              'com.example', 'mytype', Uint8List.fromList('mydata'.codeUnits)),
        ]);

        try {
          await ndef.write(message);
          result.value = 'Success to "Ndef Write"';
          NfcManager.instance.stopSession();
        } catch (e) {
          result.value = e;
          NfcManager.instance.stopSession(errorMessage: result.value.toString());
          return;
        }
      });
    }catch(e){
      print("_ndefWrite: " + e.toString());
    }
  }

  void _ndefWriteLock() {
    try{
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        var ndef = Ndef.from(tag);
        if (ndef == null) {
          result.value = 'Tag is not ndef';
          NfcManager.instance.stopSession(errorMessage: result.value.toString());
          return;
        }

        try {
          await ndef.writeLock();
          result.value = 'Success to "Ndef Write Lock"';
          NfcManager.instance.stopSession();
        } catch (e) {
          result.value = e;
          NfcManager.instance.stopSession(errorMessage: result.value.toString());
          return;
        }
      });
    }catch(e){
      print("_ndefWriteLock: "+e.toString());
    }
  }

}
