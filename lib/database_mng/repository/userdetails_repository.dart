import 'package:nfcdemo/database_mng/db/user_db.dart';
import 'package:nfcdemo/database_mng/db/userdetails_db.dart';
import 'package:nfcdemo/models/VWStudentFullDetailNullable.dart';
import 'package:nfcdemo/models/models.dart';

class UserDetailsRepository {
  static UserDetailsDB dbUserDetailsObject = UserDetailsDB();

  static Future<int> addUserDetails(
          VWStudentFullDetailNullable vwStudentFullDetailNullable) =>
      dbUserDetailsObject.addUserDetails(vwStudentFullDetailNullable);

  static Future<bool> deleteUserDetails(int userID) =>
      dbUserDetailsObject.deleteUserDetails(userID);

  static Future<List<VWStudentFullDetailNullable>> getUserDetails() =>
      dbUserDetailsObject.getUserDetails();

  static clearData() => dbUserDetailsObject.clearData();

  static Future<VWStudentFullDetailNullable> getUserDetailsByID(int userID) =>
      dbUserDetailsObject.getUserDetailsByID(userID);

  static Future<VWStudentFullDetailNullable> getCurrentUserDetails() =>
      dbUserDetailsObject.getCurrentUserDetails();

  static UserDB dbUserObject = UserDB();

  static Future<int> addUser(User user) => dbUserObject.addUser(user);

  static Future<bool> deleteUser(int userID) => dbUserObject.deleteUser(userID);

  static Future<List<User>> getUsers() => dbUserObject.getUsers();

  static clearUserData() => dbUserObject.clearData();

  static Future<User> getUserByID(int userID) =>
      dbUserObject.getUserByID(userID);
}

//https://github.com/abuanwar072/20-Error-States-Flutter/tree/master/lib/screens
