part of 'user_list_bloc.dart';

abstract class UserListState {}
  
class InitialUserListState extends UserListState {}

class Loading extends UserListState {}

class Failure extends UserListState {
  final String errorMessage;
  Failure({required this.errorMessage});
}

class UsersLoaded extends UserListState {
  final List<User> users;
  UsersLoaded({required this.users});
}