import 'package:fluttalk/model/message.dart';

class Chat {
  String id;
  String title;
  List<String> members;
  DateTime createdAt;
  DateTime updatedAt;
  Message? lastMessage;

  Chat({
    required this.id,
    required this.title,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
    this.lastMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'] as String,
      title: json['title'] as String,
      members: List<String>.from(json['members']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updatedAt']),
      lastMessage: json['lastMessage'] != null
          ? Message.fromJson(json['lastMessage'])
          : null,
    );
  }

  String get lastMessageContent => lastMessage?.content ?? '';
}
