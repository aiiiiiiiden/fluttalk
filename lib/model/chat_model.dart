import 'package:fluttalk/model/firebase_repository.dart';
import 'package:flutter/material.dart';

class ChatModel extends ChangeNotifier {
  // Queue<Chat> _chats = Queue();
  bool _isLoaded = false;
  final FirebaseRepository repository;

  ChatModel({required this.repository});

  // Chat get(int index) {
  //   return _chats.elementAt(index);
  // }

  // load() async {
  //   final chatsResponse = await repository.getChats();
  //   _chats = Queue.from(chatsResponse.chats);
  //   _isLoaded = true;
  //   notifyListeners();
  // }

  // Future<Chat> create(User user, String title) async {
  //   final chatResponse = await repository.createChat(user.email, title);
  //   _chats.add(chatResponse.chat);
  //   notifyListeners();
  //   return chatResponse.chat;
  // }
}
