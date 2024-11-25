import 'package:fluttalk/model/user.dart';

class UserResponse {
  final User user;

  UserResponse({required this.user});

  String get email => user.email;

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(user: User.fromJson(json['result']));
  }
}
