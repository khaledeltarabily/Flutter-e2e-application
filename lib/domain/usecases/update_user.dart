import 'package:e2e_application/domain/entities/user.dart';
import 'package:e2e_application/domain/repositories/user_repository.dart';

class UpdateUserUseCase {
  final IUserRepository repository;

  UpdateUserUseCase(this.repository);

  Future<int> call(User user) => repository.updateUser(user);

}
