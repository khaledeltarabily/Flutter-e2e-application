import 'package:e2e_application/domain/entities/user.dart';
import 'package:e2e_application/domain/repositories/user_repository.dart';

class GetAllUsersUseCase {
  final IUserRepository repository;

  GetAllUsersUseCase(this.repository);

  Future<List<User>> call({String? query}) => repository.getUsers(query: query);

}