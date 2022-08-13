import 'package:e2e_application/domain/repositories/user_repository.dart';

class DeleteAllUsersUseCase {
  final IUserRepository repository;

  DeleteAllUsersUseCase(this.repository);

  Future<int> call() => repository.deleteAllUsers();

}
