
import 'package:e2e_application/data/data_sources/local/user_local_data_source.dart';
import 'package:e2e_application/data/models/user_model.dart';
import 'package:e2e_application/domain/entities/user.dart';
import 'package:e2e_application/domain/repositories/user_repository.dart';

class UserRepository implements IUserRepository{
  final UserLocalDataSource userLocalDataSource;

  UserRepository({required this.userLocalDataSource});

  @override
  Future<List<User>> getUsers({String? query}) =>
      userLocalDataSource.getUsers(query: query);

  @override
  Future<User?> getUser(int id) => userLocalDataSource.getUser(id: id);

  @override
  Future<int> addUser(User user) {
    final UserModel userModel = UserModel(
        id: user.id,
      email: user.email,
      name:user.name,
      username:user.username,
    );
   return userLocalDataSource.createUser(userModel);
  }

  @override
  Future<int> updateUser(User user){
    final UserModel userModel = UserModel(
      id: user.id,
      email: user.email,
      name:user.name,
      username:user.username,
    );
    return userLocalDataSource.updateUser(userModel);

  }
  @override
  Future<int> deleteUser(int id) => userLocalDataSource.deleteUser(id);

  @override
  Future<int> deleteAllUsers() => userLocalDataSource.deleteAllUsers();

  @override
  Future<void> dispose() => userLocalDataSource.closeDatabase();
}