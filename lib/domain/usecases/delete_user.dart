import 'package:e2e_application/domain/repositories/user_repository.dart';

class DeleteUserUseCase {
  final IUserRepository repository;

  DeleteUserUseCase(this.repository);

  Future<int> call(int userId) => repository.deleteUser(userId);

}