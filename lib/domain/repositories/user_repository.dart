import 'package:e2e_application/domain/entities/user.dart';

abstract class IUserRepository {

  Future<List<User>> getUsers({String? query});

  Future<User?> getUser(int id);

  Future<int> addUser(User user);

  Future<int> updateUser(User user);

  Future<int> deleteUser(int id);

  Future<int> deleteAllUsers();

  Future<void> dispose();

}