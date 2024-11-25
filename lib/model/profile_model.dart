import 'package:fluttalk/model/firebase_repository.dart';
import 'package:fluttalk/model/user.dart';
import 'package:flutter/material.dart';

class ProfileModel extends ChangeNotifier {
  User? user;
  final FirebaseRepository repository;
  ProfileModel({
    required this.repository,
  });

  String get email => user?.email ?? "";
  String get name => user?.displayName ?? "";

  load() async {
    final userResponse = await repository.getMe();
    user = userResponse.user;
    notifyListeners();
  }

  update(String name) async {
    final userResponse = await repository.updateMe(name);
    user = userResponse.user;
    notifyListeners();
  }
}
