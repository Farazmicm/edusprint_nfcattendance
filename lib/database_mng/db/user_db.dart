import 'package:hive/hive.dart';
import 'package:nfcdemo/database_mng/interface/user_interface.dart';
import 'package:nfcdemo/models/models.dart';

class UserDB implements UserInterface {
  final String TABLE_NAME = "users";

  @override
  Future<int> addUser(User user) async {
    try {
      return await Hive.openBox(TABLE_NAME).then((box) async {
        return await box.add(user.toJson());
      });
    } catch (e) {
      print("addUser: " + e.toString());
      return 0;
    }
  }

  @override
  Future<List<User>> getUsers() async {
    List<User> listUsers = List<User>.empty(growable: true);
    try {
      var box = await Hive.openBox(TABLE_NAME);
      for (int i = 1; i < box.length; i++) {
        Map<String, dynamic> userMap = Map.from(box.getAt(i));
        listUsers.add(User.fromJson(userMap));
      }
    } catch (e) {
      print("getUsers: " + e.toString());
    }
    return listUsers;
  }

  @override
  Future<bool> deleteUser(int userID) async {
    var o = false;
    try {
      var box = await Hive.openBox(TABLE_NAME);
      for (int i = 1; i < box.length; i++) {
        Map<String, dynamic> userMap = Map.from(box.getAt(i));
        var oUser = User.fromJson(userMap);
        if (oUser.UserID == userID) {
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
  Future<User> getUserByID(int userID) async {
    try {
      return await getUsers().then((value) {
        if (value.isNotEmpty && value.length > 0) {
          return value.where((element) => element.UserID == userID).first;
        } else {
          return User.toNullObject();
        }
      });
    } catch (e) {
      print("getUserByID: " + e.toString());
      return User.toNullObject();
    }
  }




}
