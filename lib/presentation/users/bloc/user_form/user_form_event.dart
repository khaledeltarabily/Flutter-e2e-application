part of 'user_form_bloc.dart';


@immutable
abstract class UserFormEvent {}

class CreateUserForm extends UserFormEvent {}

class GetUser extends UserFormEvent {
  final int userId;
  GetUser({required this.userId});
}

class CreateUser extends UserFormEvent {
  final User user;
  CreateUser({required this.user});
}

class UpdateUser extends UserFormEvent {
  final User user;
  UpdateUser({required this.user});
}
