import 'user_metadata.dart';

class User {
  String email;
  String displayName;
  UserMetadata userMetadata;

  User({
    required this.email,
    required this.displayName,
    required this.userMetadata,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] as String,
      displayName: json['displayName'] as String? ?? '',
      userMetadata: UserMetadata.fromJson(json['metadata']),
    );
  }

  DateTime get lastSignInTime => userMetadata.lastSignInTime;
}
