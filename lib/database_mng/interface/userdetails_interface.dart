import 'package:nfcdemo/models/VWStudentFullDetailNullable.dart';

abstract class UserDetailsInterface {
  Future<int> addUserDetails(
      VWStudentFullDetailNullable vwStudentFullDetailNullable);

  Future<List<VWStudentFullDetailNullable>> getUserDetails();

  Future<bool> deleteUserDetails(int userID);

  Future<VWStudentFullDetailNullable> getUserDetailsByID(int userID);

  Future<VWStudentFullDetailNullable> getCurrentUserDetails();

  clearData();
}
