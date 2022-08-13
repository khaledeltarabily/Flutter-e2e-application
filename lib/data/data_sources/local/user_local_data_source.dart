
import 'package:e2e_application/data/models/user_model.dart';

abstract class UserLocalDataSource {

  Future<List<UserModel>> getUsers({String? query});
  Future<UserModel?> getUser({required int id});
  Future<int> createUser(UserModel user);
  Future<int> updateUser(UserModel user);
  Future<int> deleteUser(int id);
  Future<int> deleteAllUsers();
  Future<void> closeDatabase();

}
