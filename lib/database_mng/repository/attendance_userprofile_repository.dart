import 'package:nfcdemo/database_mng/db/user_db.dart';
import 'package:nfcdemo/database_mng/db/attendance_userprofile_db.dart';
import 'package:nfcdemo/models/attendanceUserDetailsModel.dart';
import 'package:nfcdemo/models/models.dart';

class AttendanceUserProfileRepository {
  static AttendanceUserProfileDB dbAttendanceUserProfileObject = AttendanceUserProfileDB();

  static Future<int> addAttendanceUserProfile(AttendanceUserDetails attendanceUserDetails) => dbAttendanceUserProfileObject.addAttendanceUserProfile(attendanceUserDetails);

  static Future<Iterable<int>> addAttendanceUserProfileAll(List<AttendanceUserDetails> attendanceUserDetails) => dbAttendanceUserProfileObject.addAttendanceUserProfileAll(attendanceUserDetails);

  static Future<bool> deleteAttendanceUserProfile(int userID) => dbAttendanceUserProfileObject.deleteAttendanceUserProfile(userID);

  static Future<List<AttendanceUserDetails>> getAttendanceUserProfiles() => dbAttendanceUserProfileObject.getAttendanceUserProfiles();

  static clearAttendanceUserProfileData() => dbAttendanceUserProfileObject.clearData();

  static Future<AttendanceUserDetails> getAttendanceUserProfileByID(int userID) =>
      dbAttendanceUserProfileObject.getAttendanceUserProfileByID(userID);
}

//https://github.com/abuanwar072/20-Error-States-Flutter/tree/master/lib/screens
