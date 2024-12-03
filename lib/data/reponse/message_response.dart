import 'package:fluttalk/data/message.dart';

class MessageResponse {
  final Message message;

  MessageResponse({required this.message});

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(message: Message.fromJson(json['result']));
  }
}
