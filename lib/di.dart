
import 'package:e2e_application/data/data_sources/local/app_local_data_source.dart';
import 'package:e2e_application/data/data_sources/local/database/indexed_database_provider.dart';
import 'package:e2e_application/data/data_sources/local/database/sql_database_provider.dart';
import 'package:e2e_application/data/data_sources/local/user_local_data_source.dart';
import 'package:e2e_application/data/data_sources/local/web_local_data_source.dart';
import 'package:e2e_application/data/repositories/user_repository_impl.dart';
import 'package:e2e_application/domain/repositories/user_repository.dart';
import 'package:e2e_application/domain/usecases/add_user.dart';
import 'package:e2e_application/domain/usecases/delete_all_users.dart';
import 'package:e2e_application/domain/usecases/delete_user.dart';
import 'package:e2e_application/domain/usecases/get_all_posts.dart';
import 'package:e2e_application/domain/usecases/get_post.dart';
import 'package:e2e_application/domain/usecases/release_resources.dart';
import 'package:e2e_application/domain/usecases/update_user.dart';
import 'package:e2e_application/presentation/users/bloc/user_form/user_form_bloc.dart';
import 'package:e2e_application/presentation/users/bloc/users_list/user_list_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
      () => UserFormBloc(addUser: sl(), getUser: sl(), updateUser: sl()));
  sl.registerFactory(() => UserListBloc(
        getUsers: sl(),
        deleteUser: sl(),
        deleteAllUsers: sl(),
        releaseResources: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetAllUsersUseCase(sl()));
  sl.registerLazySingleton(() => AddUserUseCase(sl()));
  sl.registerLazySingleton(() => DeleteUserUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAllUsersUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(sl()));
  sl.registerLazySingleton(() => GetUserUseCase(sl()));
  sl.registerLazySingleton(() => ReleaseResourcesUseCase(sl()));

  // Repository
  sl.registerLazySingleton<IUserRepository>(
      () => UserRepository(userLocalDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<UserLocalDataSource>(
      () => kIsWeb
          ? WebLocalDataSource(dbProvider: sl())
          :AppLocalDataSource(dbProvider: sl())
  );

  //Database
  sl.registerLazySingleton<SQLDatabaseProvider>(() => SQLDatabaseProvider());
  sl.registerLazySingleton<IndexedDatabaseProvider>(() => IndexedDatabaseProvider(sl()));
  sl.registerLazySingleton(() => databaseFactoryWeb);

}
