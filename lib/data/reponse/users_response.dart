import 'package:fluttalk/data/user.dart';

class UsersResponse {
  final List<User> users;

  UsersResponse({required this.users});

  factory UsersResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<User> users = list.map((i) => User.fromJson(i)).toList();
    return UsersResponse(users: users);
  }
}
