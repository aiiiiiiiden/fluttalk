import 'package:intl/intl.dart';

class UserMetadata {
  DateTime lastSignInTime;

  UserMetadata({
    required this.lastSignInTime,
  });

  factory UserMetadata.fromJson(Map<String, dynamic> json) {
    DateFormat format = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'");
    DateTime dateTime = format.parseUTC(json['lastSignInTime'] as String);
    return UserMetadata(
      lastSignInTime: dateTime,
    );
  }
}
