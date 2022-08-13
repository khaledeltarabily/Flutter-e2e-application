import 'package:e2e_application/domain/entities/user.dart';
import 'package:e2e_application/domain/repositories/user_repository.dart';

class AddUserUseCase {
  final IUserRepository repository;

  AddUserUseCase(this.repository);

  Future<int> call(User user) => repository.addUser(user);

}
