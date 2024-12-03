import 'package:fluttalk/data/message.dart';

class MessagesResponse {
  final List<Message> messages;
  final String? nextKey;

  MessagesResponse({required this.nextKey, required this.messages});

  factory MessagesResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    var nextKey = json['nextKey'] != null ? json['nextKey'] as String : null;
    List<Message> messages = list.map((i) => Message.fromJson(i)).toList();
    return MessagesResponse(nextKey: nextKey, messages: messages);
  }
}
