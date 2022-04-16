import 'package:hive/hive.dart';
import 'package:nfcdemo/database_mng/interface/userdetails_interface.dart';
import 'package:nfcdemo/enum/enum.dart';
import 'package:nfcdemo/models/VWStudentFullDetailNullable.dart';
import 'package:nfcdemo/utilities/utility.dart';

class UserDetailsDB implements UserDetailsInterface {
  final String TABLE_NAME = "students";

  @override
  Future<int> addUserDetails(
      VWStudentFullDetailNullable vwStudentFullDetailNullable) async {
    try {
      return await Hive.openBox(TABLE_NAME).then((box) async {
        return await box.add(vwStudentFullDetailNullable.toJson());
      });
    } catch (e) {
      print("addUser: " + e.toString());
      return 0;
    }
  }

  @override
  Future<List<VWStudentFullDetailNullable>> getUserDetails() async {
    List<VWStudentFullDetailNullable> listUsers =
        List<VWStudentFullDetailNullable>.empty(growable: true);
    try {
      var box = await Hive.openBox(TABLE_NAME);
      for (int i = 1; i < box.length; i++) {
        Map<String, dynamic> userMap = Map.from(box.getAt(i));
        listUsers.add(VWStudentFullDetailNullable.fromJson(userMap));
      }
    } catch (e) {
      print("");
    }

    return listUsers;
  }

  @override
  Future<bool> deleteUserDetails(int userID) async {
    var o = false;
    try {
      var box = await Hive.openBox(TABLE_NAME);
      for (int i = 1; i < box.length; i++) {
        Map<String, dynamic> userMap = Map.from(box.getAt(i));
        var oVW = VWStudentFullDetailNullable.fromJson(userMap);
        if (oVW.UserID == userID) {
          box.deleteAt(i);
          o = true;
        }
      }
    } catch (e) {
      o = false;
    }
    return o;
  }

  @override
  clearData() async {
    await Hive.openBox(TABLE_NAME).then((box) async => await box.clear());
  }

  @override
  Future<VWStudentFullDetailNullable> getUserDetailsByID(int userID) async {
    try {
      return await getUserDetails().then((value) {
        if (value.isNotEmpty && value.length > 0) {
          return value.where((element) => element.UserID == userID).first;
        } else {
          return VWStudentFullDetailNullable.toNullObject();
        }
      });
    } catch (e) {
      print("getUserDetailsByID: " + e.toString());
      return VWStudentFullDetailNullable.toNullObject();
    }
  }

  @override
  Future<VWStudentFullDetailNullable> getCurrentUserDetails() async {
    try {
      return await Utility.readLocalStorage(
              localStorageKeyEnum.UserID.toString())
          .then((userID) async {
        if (userID.isNotEmpty) {
          return await getUserDetails().then((value) {
            if (value.isNotEmpty) {
              return value
                  .where((element) => element.UserID == int.parse(userID))
                  .first;
            } else {
              return VWStudentFullDetailNullable.toNullObject();
            }
          });
        } else {
          return VWStudentFullDetailNullable.toNullObject();
        }
      });
    } catch (e) {
      print("getCurrentUserDetails: " + e.toString());
      return VWStudentFullDetailNullable.toNullObject();
    }
  }
}
