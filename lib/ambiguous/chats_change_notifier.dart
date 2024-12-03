import 'package:fluttalk/ambiguous/chat_change_notifier.dart';
import 'package:fluttalk/data/chat.dart';
import 'package:fluttalk/data/repository/firebase_firestore_repository.dart';
import 'package:fluttalk/data/repository/firebase_function_repository.dart';
import 'package:fluttalk/data/user.dart';
import 'package:flutter/material.dart';

class ChatsChangeNotifier extends ChangeNotifier {
  final FirebaseFunctionRepository functions;
  final FirebaseFirestoreRepository firestore;
  List<Chat> _chats = [];
  bool _isLoaded = false;
  int get chatsCount => _chats.length;
  bool get isNotExist => _isLoaded && _chats.isEmpty;

  ChatsChangeNotifier({
    required this.functions,
    required this.firestore,
  });

  Chat get(int index) {
    return _chats.elementAt(index);
  }

  load() async {
    final chatsResponse = await functions.getChats();
    _chats = chatsResponse.chats;
    _isLoaded = true;
    notifyListeners();
  }

  Future<ChatChangeNotifier> create(User user, String title) async {
    final chatResponse = await functions.createChat(user.email, title);
    _chats.add(chatResponse.chat);
    notifyListeners();
    return ChatChangeNotifier(
      chat: chatResponse.chat,
      functions: functions,
      firestore: firestore,
    );
  }
}
