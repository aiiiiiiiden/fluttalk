import 'package:fluttalk/data/chat.dart';
import 'package:fluttalk/data/repository/firebase_firestore_repository.dart';
import 'package:fluttalk/data/repository/firebase_function_repository.dart';
import 'package:fluttalk/data/message.dart';
import 'package:flutter/material.dart';

class ChatChangeNotifier extends ChangeNotifier {
  final FirebaseFunctionRepository functions;
  final FirebaseFirestoreRepository firestore;
  final Chat chat;
  List<Message>? messages;
  bool _isLoading = false;
  String? nextKey;
  bool get _isEmpty => messages?.isEmpty ?? true;

  int get count => messages?.length ?? 0;
  bool get canLoadMore => !_isLoading && nextKey != null;
  Message? get(int index) {
    if (_isEmpty) {
      return null;
    } else {
      return messages!.elementAt(messages!.length - index - 1);
    }
  }

  ChatChangeNotifier({
    required this.chat,
    required this.functions,
    required this.firestore,
  });

  Future<void> loadMore() async {
    if (_isLoading || nextKey == null) {
      return;
    }

    try {
      _isLoading = true;
      final messagesResponse = await functions.getMessages(
        chat.id,
        startAt: nextKey,
      );
      messages?.addAll(messagesResponse.messages);
      nextKey = messagesResponse.nextKey;
      notifyListeners();
    } finally {
      _isLoading = false;
    }
  }

  loadNewMessages() async {
    if (_isEmpty) {
      final messagesResponse = await functions.getMessages(chat.id);
      messages = messagesResponse.messages;
      nextKey = messagesResponse.nextKey;
    } else {
      final newMessagesResponse = await functions.getNewMessages(
        chatId: chat.id,
        lastNewestSentAt: messages!.first.sentAt,
      );
      messages?.insertAll(0, newMessagesResponse.messages);
    }
    notifyListeners();
  }

  sendMessage(String chatId, String content) async {
    await functions.sendMessage(chatId, content);
  }

  Stream<Chat?> changedChat() {
    return firestore.stream<Chat>(
      collection: "chats",
      document: chat.id,
      converter: Chat.fromJson,
    );
  }
}
