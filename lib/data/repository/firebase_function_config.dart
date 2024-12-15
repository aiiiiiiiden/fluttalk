import 'dart:io';

enum FirebaseFunctions {
  removeFriendByEmail,
  getFriends,
  addFriendsByEmail,
  getChats,
  postChat,
  getMe,
  postMe,
  sendMessage,
  getMessages,
  getLatestMessages,
  postPushToken,
}

class FirebaseFunctionsConfig {
  final bool isLocal;
  FirebaseFunctionsConfig({required this.isLocal});

  String baseUrl(bool isLocal) {
    if (isLocal) {
      return "http://${(Platform.isIOS ? "127.0.0.1" : "10.0.2.2")}/fluttalk/us-central1/api";
    } else {
      return "https://api-cwpwobd65q-uc.a.run.app";
    }
  }

  String getUrl(FirebaseFunctions type) => switch (type) {
        FirebaseFunctions.getMe => "${baseUrl(isLocal)}/users/me",
        FirebaseFunctions.postMe => "${baseUrl(isLocal)}/users/me",
        FirebaseFunctions.addFriendsByEmail => "${baseUrl(isLocal)}/friends",
        FirebaseFunctions.removeFriendByEmail => "${baseUrl(isLocal)}/friends",
        FirebaseFunctions.getFriends => "${baseUrl(isLocal)}/friends",
        FirebaseFunctions.getChats => "${baseUrl(isLocal)}/chats",
        FirebaseFunctions.postChat => "${baseUrl(isLocal)}/chats",
        FirebaseFunctions.sendMessage => "${baseUrl(isLocal)}/messages",
        FirebaseFunctions.getMessages => "${baseUrl(isLocal)}/messages",
        FirebaseFunctions.getLatestMessages =>
          "${baseUrl(isLocal)}/messages/latest",
        FirebaseFunctions.postPushToken => "${baseUrl(isLocal)}/pushTokens",
      };
}
