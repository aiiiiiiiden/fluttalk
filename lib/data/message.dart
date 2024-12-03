class Message {
  String id;
  String chatId;
  String sender;
  String content;
  int sentAt;

  Message({
    required this.id,
    required this.chatId,
    required this.sender,
    required this.content,
    required this.sentAt,
  });

  bool isUsers(String usersUid) {
    return sender == usersUid;
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      chatId: json['chatId'] as String,
      sender: json['sender'] as String,
      content: json['content'] as String,
      sentAt: json['sentAt'] as int,
    );
  }
}
