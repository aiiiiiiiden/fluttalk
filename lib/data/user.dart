import 'user_metadata.dart';

class User {
  String email;
  String uid;
  String displayName;
  UserMetadata userMetadata;

  User({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.userMetadata,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String? ?? '',
      userMetadata: UserMetadata.fromJson(json['metadata']),
    );
  }

  DateTime get lastSignInTime => userMetadata.lastSignInTime;
}
