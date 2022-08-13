import 'dart:async';

import 'package:e2e_application/domain/entities/user.dart';
import 'package:e2e_application/domain/usecases/add_user.dart';
import 'package:e2e_application/domain/usecases/get_post.dart';
import 'package:e2e_application/domain/usecases/update_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_form_event.dart';
part 'user_form_state.dart';

class UserFormBloc extends Bloc<UserFormEvent, UserFormState> {
  UserFormBloc({
    required this.getUser,
    required this.addUser,
    required this.updateUser,
  }) : super(InitialUserFormState()) {
    on<GetUser>(_getUser);
    on<CreateUserForm>(_createUserForm);
    on<CreateUser>(_createUser);
    on<UpdateUser>(_updateUser);
  }

  final GetUserUseCase getUser;
  final AddUserUseCase addUser;
  final UpdateUserUseCase updateUser;

  Future<void> _createUserForm(
      CreateUserForm event, Emitter<UserFormState> emit) async {
    emit(Loaded(user: User.empty));
  }

  Future<void> _getUser(GetUser event, Emitter<UserFormState> emit) async {
    emit(Loading());
    try {
      final user = await getUser.call(event.userId);
      if (user != null) {
        emit(Loaded(user: user));
        return;
      }
      emit(Error(errorMessage: 'User Not Found'));
    } catch (e) {
      emit(Error(errorMessage: e.toString()));
    }
  }

  Future<void> _createUser(
      CreateUser event, Emitter<UserFormState> emit) async {
    emit(Loading());
    try {
      await addUser.call(event.user);
      emit(Success(successMessage: "${event.user.name}  created"));
    } catch (e) {
      emit(Error(errorMessage: e.toString()));
    }
  }

  Future<void> _updateUser(
      UpdateUser event, Emitter<UserFormState> emit) async {
    emit(Loading());
    try {
      await updateUser.call(event.user);
      emit(Success(successMessage: "${event.user.name}  updated"));
    } catch (e) {
      emit(Error(errorMessage: e.toString()));
    }
  }
}
