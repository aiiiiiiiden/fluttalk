import 'package:fluttalk/data/repository/firebase_function_repository.dart';
import 'package:fluttalk/data/user.dart';
import 'package:flutter/material.dart';

class UserChangeNotifier extends ChangeNotifier {
  final FirebaseFunctionRepository functions;
  User? _user;
  String get email => _user?.email ?? "";
  String get name => _user?.displayName ?? "";
  String get uid => _user?.uid ?? "";

  UserChangeNotifier({
    required this.functions,
  });

  Future<void> load() async {
    final userResponse = await functions.getMe();
    _user = userResponse.user;
    notifyListeners();
  }

  Future<void> update(String name) async {
    final userResponse = await functions.updateMe(name);
    _user = userResponse.user;
    notifyListeners();
  }
}
