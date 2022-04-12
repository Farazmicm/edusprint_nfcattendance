import 'package:flutter/material.dart';
import 'package:nfcdemo/common/app_routing.dart' as routing;

void main() {
  runApp(const MyApp());
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
    var theme = Theme.of(context);
          return MaterialApp(
            title: 'Edusprint Attendance',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.grey.shade100,
              colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.blue.shade300,
                primaryVariant: Colors.blue[50],
                secondary: Colors.blue,
                secondaryVariant:Colors.blue.shade600,
                background: Colors.white,
              ),
              appBarTheme: AppBarTheme(
                titleSpacing: 10,
                centerTitle: false,
                elevation: 3,
              ),
              tabBarTheme: TabBarTheme(
                  labelColor: theme.colorScheme.secondary,
                  unselectedLabelColor: Colors.white,
                  indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)))),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.shifting,
                backgroundColor: theme.colorScheme.background,
                elevation: 8.0,
                selectedItemColor: theme.colorScheme.primary,
                unselectedItemColor: Colors.grey.shade600,
                showSelectedLabels: true,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue.shade300,),
                      elevation: MaterialStateProperty.all(6),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      textStyle: MaterialStateProperty.all(TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      )))),
              textTheme: const TextTheme(
                headline2: TextStyle(
                    fontSize: 20, color: Colors.black54, fontWeight: FontWeight.w600),
                headline3: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                  focusColor: Colors.blue,
                  floatingLabelBehavior: FloatingLabelBehavior.auto),
              cardTheme: CardTheme(
                  color: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  elevation: 2,
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                    side: BorderSide(color: Colors.grey.shade100, width: 1),

                  )),
              dataTableTheme: DataTableThemeData(
                decoration: BoxDecoration(shape: BoxShape.rectangle),
                headingRowHeight: 35,
                headingRowColor: MaterialStateProperty.all(Colors.grey.shade400),
                dataRowHeight: 40,
              ),
            ),
            onGenerateRoute: routing.generateRoute,
            initialRoute: "/",
          );
  }
}
