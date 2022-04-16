import 'package:nfcdemo/models/models.dart';

abstract class UserProfileInterface {
  Future<int> addUserProfile(UserProfile userProfile);

  Future<List<UserProfile>> getUserProfiles();

  Future<bool> deleteUserProfile(int userID);

  Future<UserProfile> getUserProfileByID(int userID);

  clearData();
}
