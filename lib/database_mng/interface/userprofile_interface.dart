import 'package:nfcdemo/models/models.dart';

abstract class UserProfileInterface {
  Future<int> addUserProfile(UserProfileModel userProfileModel);

  Future<List<UserProfileModel>> getUserProfiles();

  Future<bool> deleteUserProfile(int userID);

  Future<UserProfileModel> getUserProfileByID(int userID);

  clearData();
}
