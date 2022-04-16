import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseProvider {
  static initHive() async {
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      print("DB Initialized");
    } catch (e) {
      print("DB Initialization error." + e.toString());
    }
  }

  static closeHive() async => await Hive.close();

  static clearAllData() async => await Hive.deleteFromDisk();

  static clearSpecificBox(String boxName) async =>
      await Hive.deleteBoxFromDisk(boxName);
}
