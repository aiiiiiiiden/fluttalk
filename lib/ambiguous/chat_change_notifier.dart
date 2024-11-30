import 'package:fluttalk/data/chat.dart';
import 'package:fluttalk/data/repository/firebase_function_repository.dart';
import 'package:fluttalk/data/message.dart';
import 'package:flutter/material.dart';

class ChatChangeNotifier extends ChangeNotifier {
  List<Message> messages;
  bool _isLoading = false;
  final FirebaseFunctionRepository repository;
  final Chat chat;
  String? nextKey;

  ChatChangeNotifier._({
    required this.chat,
    required this.messages,
    required this.nextKey,
    required this.repository,
  });

  static Future<ChatChangeNotifier> create(
    Chat chat,
    FirebaseFunctionRepository repository,
  ) async {
    final messagesResponse = await repository.getMessages(chat.id);
    return ChatChangeNotifier._(
      chat: chat,
      messages: messagesResponse.messages,
      nextKey: messagesResponse.nextKey,
      repository: repository,
    );
  }

  int get count => messages.length;
  bool get isLoading => _isLoading;
  Message get(int index) => messages.elementAt(messages.length - index - 1);

  Future<void> loadMore() async {
    if (_isLoading || nextKey == null) {
      return;
    }

    try {
      _isLoading = true;
      final messagesResponse = await repository.getMessages(
        chat.id,
        startAt: nextKey,
      );
      messages.addAll(messagesResponse.messages);
      nextKey = messagesResponse.nextKey;
      notifyListeners();
    } finally {
      _isLoading = false;
    }
  }

  sendMessage(String chatId, String content) async {
    final messageResponse = await repository.sendMessage(chatId, content);
    messages.insert(0, messageResponse.message);
    notifyListeners();
  }
}
