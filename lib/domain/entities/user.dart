
import 'package:equatable/equatable.dart';

class User extends Equatable{
  final int? id;
  final String name;
  final String username;
  final String email;

 const User({
    this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  @override
  List<Object?> get props => [id,name,username,email];

  static const empty = User(id: null,name:'',username:'',email: '');

}