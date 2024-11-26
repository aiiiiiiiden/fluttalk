import 'package:fluttalk/model/firebase_repository.dart';
import 'package:fluttalk/model/message.dart';
import 'package:flutter/material.dart';

class ChatModel extends ChangeNotifier {
  final List<Message> _messages = [];
  final FirebaseRepository repository;

  ChatModel({required this.repository});

  int get count => _messages.length;
  Message get(int index) => _messages.elementAt(index);

  sendMessage(String chatId, String content) async {
    final messageResponse = await repository.sendMessage(chatId, content);
    _messages.add(messageResponse.message);
    notifyListeners();
  }
}
