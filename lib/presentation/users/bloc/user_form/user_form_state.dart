part of 'user_form_bloc.dart';

@immutable
abstract class UserFormState {}
  
class InitialUserFormState extends UserFormState {}

class Loading extends UserFormState {}

class Error extends UserFormState {
  final String errorMessage;
  Error({required this.errorMessage});
}

class Loaded extends UserFormState {
  final User user;
  Loaded({required this.user});
}

class Success extends UserFormState {
  final String successMessage;
  Success({required this.successMessage});
}
