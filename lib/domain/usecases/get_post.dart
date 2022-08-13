import 'package:e2e_application/domain/entities/user.dart';
import 'package:e2e_application/domain/repositories/user_repository.dart';

class GetUserUseCase {
  final IUserRepository repository;

  GetUserUseCase(this.repository);

  Future<User?> call(int id) => repository.getUser(id);
}
