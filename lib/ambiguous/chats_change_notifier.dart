import 'package:fluttalk/ambiguous/chat_change_notifier.dart';
import 'package:fluttalk/data/chat.dart';
import 'package:fluttalk/data/repository/firebase_function_repository.dart';
import 'package:fluttalk/data/user.dart';
import 'package:flutter/material.dart';

class ChatsChangeNotifier extends ChangeNotifier {
  List<Chat> _chats = [];
  bool _isLoaded = false;
  final FirebaseFunctionRepository repository;
  int get chatsCount => _chats.length;
  bool get isNotExist => _isLoaded && _chats.isEmpty;

  ChatsChangeNotifier({required this.repository});

  Chat get(int index) {
    return _chats.elementAt(index);
  }

  load() async {
    final chatsResponse = await repository.getChats();
    _chats = chatsResponse.chats;
    _isLoaded = true;
    notifyListeners();
  }

  Future<ChatChangeNotifier> create(User user, String title) async {
    final chatResponse = await repository.createChat(user.email, title);
    _chats.add(chatResponse.chat);
    notifyListeners();
    return ChatChangeNotifier.create(
      chatResponse.chat,
      repository,
    );
  }
}
