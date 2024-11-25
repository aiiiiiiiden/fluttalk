import 'package:fluttalk/model/chat.dart';

class ChatsResponse {
  final List<Chat> chats;
  final String? nextKey;

  ChatsResponse({required this.nextKey, required this.chats});

  factory ChatsResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    var nextKey = json['nextKey'] != null ? json['nextKey'] as String : null;
    List<Chat> chats = list.map((i) => Chat.fromJson(i)).toList();
    return ChatsResponse(nextKey: nextKey, chats: chats);
  }
}
