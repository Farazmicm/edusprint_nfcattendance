import 'package:nfcdemo/database_mng/db/user_db.dart';
import 'package:nfcdemo/database_mng/db/userdetails_db.dart';
import 'package:nfcdemo/models/VWStudentFullDetailNullable.dart';
import 'package:nfcdemo/models/models.dart';

class UserProfileRepository {
  static UserProfileDB dbUserProfileObject = UserProfileDB();

  static Future<int> addUserProfile(UserProfile userProfile) => dbUserProfileObject.addUserProfile(userProfile);

  static Future<bool> deleteUserProfile(int userID) => dbUserProfileObject.deleteUser(userID);

  static Future<List<UserProfile>> getUserProfiles() => dbUserProfileObject.getUserProfiles();

  static clearUserProfileData() => dbUserProfileObject.clearData();

  static Future<User> getUserProfileByID(int userID) =>
      dbUserProfileObject.getUserProfileByID(userID);
}

//https://github.com/abuanwar072/20-Error-States-Flutter/tree/master/lib/screens
