part of 'user_list_bloc.dart';

abstract class UserListEvent {}

class GetUsers extends UserListEvent {
  final String? query;

  GetUsers({this.query});
}

class DeleteUser extends UserListEvent {
  final User user;

  DeleteUser({required this.user});
}

class DeleteAllUsers extends UserListEvent {
  DeleteAllUsers();
}
