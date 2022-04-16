import 'package:hive/hive.dart';
import 'package:nfcdemo/database_mng/interface/user_interface.dart';
import 'package:nfcdemo/models/models.dart';

class UserProfileDB implements UserProfileInterface {
  final String TABLE_NAME = "userprofile";

  @override
  Future<int> addUserProfile(UserProfile userProfile) async {
    try {
      return await Hive.openBox(TABLE_NAME).then((box) async {
        return await box.add(userProfile.toJson());
      });
    } catch (e) {
      print("addUserProfile: " + e.toString());
      return 0;
    }
  }

  @override
  Future<List<UserProfile>> getUserProfiles() async {
    List<UserProfile> listUsers = List<UserProfile>.empty(growable: true);
    try {
      var box = await Hive.openBox(TABLE_NAME);
      for (int i = 1; i < box.length; i++) {
        Map<String, dynamic> userMap = Map.from(box.getAt(i));
        listUsers.add(UserProfile.fromJson(userMap));
      }
    } catch (e) {
      print("getUserProfiles: " + e.toString());
    }
    return listUsers;
  }

  @override
  Future<bool> deleteUserProfile(int userID) async {
    var o = false;
    try {
      var box = await Hive.openBox(TABLE_NAME);
      for (int i = 1; i < box.length; i++) {
        Map<String, dynamic> userMap = Map.from(box.getAt(i));
        var oUser = UserProfile.fromJson(userMap);
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
  Future<User> getUserProfileByID(int userID) async {
    try {
      return await getUsers().then((value) {
        if (value.isNotEmpty && value.length > 0) {
          return value.where((element) => element.UserID == userID).first;
        } else {
          return UserProfile.toNullObject();
        }
      });
    } catch (e) {
      print("getUserProfileByID: " + e.toString());
      return UserProfile.toNullObject();
    }
  }




}
