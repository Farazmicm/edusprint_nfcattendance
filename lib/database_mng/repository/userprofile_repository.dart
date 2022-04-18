import 'package:nfcdemo/database_mng/db/userprofile_db.dart';
import 'package:nfcdemo/models/models.dart';

class UserProfileRepository {
  static UserProfileDB dbUserProfileObject = UserProfileDB();

  static Future<int> addUserProfile(UserProfileModel userProfileModel) =>
      dbUserProfileObject.addUserProfile(userProfileModel);

  static Future<bool> deleteUserProfile(int userID) =>
      dbUserProfileObject.deleteUserProfile(userID);

  static Future<List<UserProfileModel>> getUserProfiles() =>
      dbUserProfileObject.getUserProfiles();

  static clearUserProfileData() => dbUserProfileObject.clearData();

  static Future<UserProfileModel> getUserProfileByID(int userID) =>
      dbUserProfileObject.getUserProfileByID(userID);
}

//https://github.com/abuanwar072/20-Error-States-Flutter/tree/master/lib/screens
