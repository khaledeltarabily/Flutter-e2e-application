import 'package:e2e_application/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    int? id,
    required String name,
    required String username,
    required String email,
  }) : super(
          id: id,
          name: name,
          username: username,
          email: email,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '');

  factory UserModel.fromMap(int id, Map<String, dynamic> map) => UserModel(
      id: id,
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
    );

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{
      'name': name,
      'username': username,
      'email': email
    };

    if (id != null) map['id'] = id ?? 0;

    return map;
  }
}
