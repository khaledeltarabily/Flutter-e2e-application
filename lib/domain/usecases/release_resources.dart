import 'package:e2e_application/domain/repositories/user_repository.dart';

class ReleaseResourcesUseCase {
  final IUserRepository repository;

  ReleaseResourcesUseCase(this.repository);

  Future<void> call() => repository.dispose();

}