class Message {
  String chatId;
  String sender;
  String content;
  int sendedAt;

  Message({
    required this.chatId,
    required this.sender,
    required this.content,
    required this.sendedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      chatId: json['chatId'] as String,
      sender: json['sender'] as String,
      content: json['content'] as String,
      sendedAt: json['sendedAt'] as int,
    );
  }
}
