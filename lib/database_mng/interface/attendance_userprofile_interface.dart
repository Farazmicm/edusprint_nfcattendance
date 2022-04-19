import 'package:nfcdemo/models/attendanceUserDetailsModel.dart';

abstract class AttendanceUserProfileInterface {
  Future<int> addAttendanceUserProfile(AttendanceUserDetails attendanceUserDetails);

  Future<Iterable<int>> addAttendanceUserProfileAll(List<AttendanceUserDetails> attendanceUserDetails);

  Future<List<AttendanceUserDetails>> getAttendanceUserProfiles();

  Future<bool> deleteAttendanceUserProfile(int userID);

  Future<AttendanceUserDetails> getAttendanceUserProfileByID(int userID);

  clearData();
}
