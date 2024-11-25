import 'package:fluttalk/model/user.dart';
import 'package:fluttalk/model/firebase_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FriendsModel extends ChangeNotifier {
  List<User> _friends = [];
  bool _isLoaded = false;
  final FirebaseRepository repository;

  FriendsModel({required this.repository});

  List<User> get friends => _friends;
  int get friendsCount => _friends.length;
  bool get isNotExist => _friends.isEmpty;
  bool get isLoaded => _isLoaded;

  User get(int index) {
    return _friends.elementAt(index);
  }

  load() async {
    final usersResponse = await repository.getFriends();
    _isLoaded = true;
    _friends = usersResponse.users;
    notifyListeners(); // 변경 사항 알림
  }

  Future<void> add(String email) async {
    final userResponse = await repository.addFriendByEmail(email);
    _friends.add(userResponse.user);
    notifyListeners();
  }

  Future<void> remove(String email) async {
    final removedUserResponse = await repository.removeFriendByEmail(email);
    _friends.removeWhere(
      (friend) => friend.email == removedUserResponse.email,
    );
    notifyListeners();
  }
}
