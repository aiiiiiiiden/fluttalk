import 'package:fluttalk/data/chat.dart';

class ChatResponse {
  final Chat chat;

  ChatResponse({required this.chat});

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(chat: Chat.fromJson(json['result']));
  }
}
