import 'dart:async';

import 'package:e2e_application/domain/entities/user.dart';
import 'package:e2e_application/domain/usecases/delete_all_users.dart';
import 'package:e2e_application/domain/usecases/delete_user.dart';
import 'package:e2e_application/domain/usecases/get_all_posts.dart';
import 'package:e2e_application/domain/usecases/release_resources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc({
    required this.getUsers,
    required this.deleteUser,
    required this.deleteAllUsers,
    required this.releaseResources,
  }) : super(InitialUserListState()) {
    on<GetUsers>(_getUsers);
    on<DeleteUser>(_deleteUser);
    on<DeleteAllUsers>(_deleteAllUsers);
  }

  final GetAllUsersUseCase getUsers;
  final DeleteUserUseCase deleteUser;
  final DeleteAllUsersUseCase deleteAllUsers;
  final ReleaseResourcesUseCase releaseResources;

  Future<void> _getUsers(GetUsers event, Emitter<UserListState> emit) async {
    emit(Loading());
    try {
      List<User> users = await getUsers.call(query: event.query);
      emit(UsersLoaded(users: users));
    } catch (e) {
      emit(Failure(errorMessage: e.toString()));
    }
  }

  Future<void> _deleteUser(
      DeleteUser event, Emitter<UserListState> emit) async {
    emit(Loading());
    try {
      final userID = event.user.id;
      if (userID == null) {
        emit(Failure(
            errorMessage: "Something went wrong you can't delete user"));
        return;
      }
      await deleteUser.call(userID);
      emit(UsersLoaded(users: await getUsers.call()));
    } catch (e) {
      emit(Failure(errorMessage: e.toString()));
    }
  }

  Future<void> _deleteAllUsers(
      DeleteAllUsers event, Emitter<UserListState> emit) async {
    emit(Loading());
    try {
      await deleteAllUsers.call();
      emit(UsersLoaded(users: await getUsers.call()));
    } catch (e) {
      emit(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() async{
    await releaseResources.call();
    return super.close();
  }
}
