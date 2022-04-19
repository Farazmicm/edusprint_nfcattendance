import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfcdemo/database_mng/database_provider.dart';
import 'package:nfcdemo/models/models.dart';
import 'package:nfcdemo/providers/connectivityProvider.dart';
import 'package:nfcdemo/routing/appRouting.dart' as router;
import 'package:nfcdemo/utilities/common.dart';
import 'package:nfcdemo/utilities/utility.dart';
import 'package:nfcdemo/widgets/global_context.dart';
import 'package:provider/provider.dart';

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) await FlutterDownloader.initialize();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
  ], child: const MyApp()));
  await DatabaseProvider.initHive();
  setConstantValue();
  setDeviceInformation();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Stream<bool> _getInternetState = (() {
      late final StreamController<bool> controller;
      controller = StreamController<bool>(
        onListen: () async {
          controller.add(Provider.of<ConnectivityProvider>(context).isOnline);
          await controller.close();
        },
      );
      return controller.stream;
    })();

    var theme = Theme.of(context);
    return StreamBuilder<bool>(
        stream: _getInternetState,
        builder: (context, snapshot) {
          return MaterialApp(
            navigatorKey: GlobalContext.navigatorKey,
            title: 'Edusprint+',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              //scaffoldBackgroundColor: Colors.grey.shade50,
              colorScheme: ThemeData().colorScheme.copyWith(
                    primary: Colors.teal.shade600,
                    primaryVariant: Colors.teal.shade100,
                    secondary: Colors.teal,
                    secondaryVariant: Colors.teal.shade400,
                    background: Colors.white,
                  ),
              appBarTheme: AppBarTheme(
                titleSpacing: 10,
                centerTitle: false,
                elevation: 3,
              ),
              tabBarTheme: TabBarTheme(
                labelColor: Colors.teal,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.teal.shade100,
                ),
                unselectedLabelColor: Colors.white,
                unselectedLabelStyle:
                    GoogleFonts.lato(fontWeight: FontWeight.w500),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.shifting,
                backgroundColor: theme.colorScheme.background,
                elevation: 8.0,
                selectedItemColor: Colors.teal.shade600,
                unselectedItemColor: Colors.grey.shade700,
                showSelectedLabels: true,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.teal.shade500,
                      ),
                      elevation: MaterialStateProperty.all(6),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      textStyle: MaterialStateProperty.all(TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      )))),
              textTheme: const TextTheme(
                headline2: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600),
                headline3: TextStyle(
                  color: Colors.teal,
                  fontSize: 15,
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                  focusColor: Colors.teal.shade600,
                  floatingLabelBehavior: FloatingLabelBehavior.auto),
              cardTheme: CardTheme(
                  color: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  elevation: 4,
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              // checkboxTheme:CheckboxThemeData(
              //   fillColor: MaterialStateProperty.all(Colors.teal),
              // )
            ),
            onGenerateRoute: router.generateRoute,
            initialRoute: '/',
          );
        });
  }
}
