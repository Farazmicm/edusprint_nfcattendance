import 'package:nfcdemo/models/models.dart';

abstract class UserInterface {
  Future<int> addUser(User user);

  Future<List<User>> getUsers();

  Future<bool> deleteUser(int userID);

  Future<User> getUserByID(int userID);

  clearData();
}
