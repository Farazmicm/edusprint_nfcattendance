import 'package:hive/hive.dart';
import 'package:nfcdemo/database_mng/interface/attendance_userprofile_interface.dart';
import 'package:nfcdemo/models/attendanceUserDetailsModel.dart';

class AttendanceUserProfileDB implements AttendanceUserProfileInterface {
  final String TABLE_NAME = "attendanceuserprofile";

  @override
  Future<int> addAttendanceUserProfile(AttendanceUserDetails attendanceUserDetails) async {
    try {
      return await Hive.openBox(TABLE_NAME).then((box) async {
        return await box.add(attendanceUserDetails.toJson());
      });
    } catch (e) {
      print("addUserProfile: " + e.toString());
      return 0;
    }
  }

  @override
  Future<Iterable<int>> addAttendanceUserProfileAll(List<AttendanceUserDetails> lstAttendanceUserDetails) async {
    try {
      return await Hive.openBox(TABLE_NAME).then((box) async {
        return await box.addAll(lstAttendanceUserDetails.map((e) => e.toJson()));
      });
    } catch (e) {
      print("Added UserProfile: " + e.toString());
      return Iterable.empty();
    }
  }

  @override
  Future<List<AttendanceUserDetails>> getAttendanceUserProfiles() async {
    List<AttendanceUserDetails> listUsers = List<AttendanceUserDetails>.empty(growable: true);
    try {
      var box = await Hive.openBox(TABLE_NAME);
      for (int i = 1; i < box.length; i++) {
        Map<String, dynamic> userMap = Map.from(box.getAt(i));
        listUsers.add(AttendanceUserDetails.fromJson(userMap));
      }
    } catch (e) {
      print("getUserProfiles: " + e.toString());
    }
    return listUsers;
  }

  @override
  Future<bool> deleteAttendanceUserProfile(int userID) async {
    var o = false;
    try {
      var box = await Hive.openBox(TABLE_NAME);
      for (int i = 1; i < box.length; i++) {
        Map<String, dynamic> userMap = Map.from(box.getAt(i));
        var oUser = AttendanceUserDetails.fromJson(userMap);
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
  Future<AttendanceUserDetails> getAttendanceUserProfileByID(int userID) async {
    try {
      return await getAttendanceUserProfiles().then((value) {
        if (value.isNotEmpty && value.length > 0) {
          return value.where((element) => element.UserID == userID).first;
        } else {
          return AttendanceUserDetails();
        }
      });
    } catch (e) {
      print("getUserProfileByID: " + e.toString());
      return AttendanceUserDetails();
    }
  }




}
