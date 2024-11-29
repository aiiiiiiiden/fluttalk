import 'package:fluttalk/data/repository/firebase_function_repository.dart';
import 'package:fluttalk/data/user.dart';
import 'package:flutter/material.dart';

class UserChangeNotifier extends ChangeNotifier {
  User? user;
  final FirebaseFunctionRepository repository;
  UserChangeNotifier({
    required this.repository,
  });

  String get email => user?.email ?? "";
  String get name => user?.displayName ?? "";
  String get uid => user?.uid ?? "";

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
