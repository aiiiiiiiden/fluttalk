import 'package:fluttalk/data/user.dart';
import 'package:fluttalk/data/repository/firebase_function_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FriendsChangeNotifier extends ChangeNotifier {
  final FirebaseFunctionRepository functions;
  List<User> _friends = [];
  bool _isLoaded = false;

  List<User> get friends => _friends;
  int get friendsCount => _friends.length;
  bool get isNotExist => _friends.isEmpty;
  bool get isLoaded => _isLoaded;

  FriendsChangeNotifier({
    required this.functions,
  });

  User get(int index) {
    return _friends.elementAt(index);
  }

  load() async {
    final usersResponse = await functions.getFriends();
    _isLoaded = true;
    _friends = usersResponse.users;
    notifyListeners(); // 변경 사항 알림
  }

  Future<void> add(String email) async {
    final userResponse = await functions.addFriendByEmail(email);
    _friends.add(userResponse.user);
    notifyListeners();
  }

  Future<void> remove(String email) async {
    final removedUserResponse = await functions.removeFriendByEmail(email);
    _friends.removeWhere(
      (friend) => friend.email == removedUserResponse.email,
    );
    notifyListeners();
  }
}
