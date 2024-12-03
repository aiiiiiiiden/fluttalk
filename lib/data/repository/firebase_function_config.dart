import 'dart:io';

class FirebaseFunctionUrl {
  final String local;
  final String prod;
  FirebaseFunctionUrl({
    required this.local,
    required this.prod,
  });

  String getUrl(bool isLocal) => isLocal ? local : prod;
}

enum FirebaseFunctions {
  removeFriendByEmail,
  getFriends,
  addFriendsByEmail,
  getChats,
  createChat,
  getMe,
  updateMe,
  sendMessage,
  getMessages,
  getNewMessages,
}

class FirebaseFunctionsConfig {
  final bool isLocal;
  FirebaseFunctionsConfig({required this.isLocal});

  String get baseUrl {
    if (isLocal) {
      return Platform.isIOS ? "http://127.0.0.1:5001" : "http://10.0.2.2:5001";
    } else {
      return "-cwpwobd65q-uc.a.run.app";
    }
  }

  String getUrl(FirebaseFunctions type) => switch (type) {
        FirebaseFunctions.addFriendsByEmail => FirebaseFunctionUrl(
            local: "$baseUrl/fluttalk/us-central1/addFriendByEmail",
            prod: "https://addfriendbyemail$baseUrl",
          ).getUrl(isLocal),
        FirebaseFunctions.removeFriendByEmail => FirebaseFunctionUrl(
            local: "$baseUrl/fluttalk/us-central1/removeFriendByEmail",
            prod: "https://removefriendbyemail$baseUrl",
          ).getUrl(isLocal),
        FirebaseFunctions.getFriends => FirebaseFunctionUrl(
            local: "$baseUrl/fluttalk/us-central1/getFriends",
            prod: "https://getfriends$baseUrl",
          ).getUrl(isLocal),
        FirebaseFunctions.getChats => FirebaseFunctionUrl(
            local: "$baseUrl/fluttalk/us-central1/getChats",
            prod: "https://getchats$baseUrl",
          ).getUrl(isLocal),
        FirebaseFunctions.createChat => FirebaseFunctionUrl(
            local: "$baseUrl/fluttalk/us-central1/createChat",
            prod: "https://createchat$baseUrl",
          ).getUrl(isLocal),
        FirebaseFunctions.getMe => FirebaseFunctionUrl(
            local: "$baseUrl/fluttalk/us-central1/getMe",
            prod: "https://getme$baseUrl",
          ).getUrl(isLocal),
        FirebaseFunctions.updateMe => FirebaseFunctionUrl(
            local: "$baseUrl/fluttalk/us-central1/updateMe",
            prod: "https://updateme$baseUrl",
          ).getUrl(isLocal),
        FirebaseFunctions.sendMessage => FirebaseFunctionUrl(
            local: "$baseUrl/fluttalk/us-central1/sendMessage",
            prod: "https://sendmessage$baseUrl",
          ).getUrl(isLocal),
        FirebaseFunctions.getMessages => FirebaseFunctionUrl(
            local: "$baseUrl/fluttalk/us-central1/getMessages",
            prod: "https://getmessages$baseUrl",
          ).getUrl(isLocal),
        FirebaseFunctions.getNewMessages => FirebaseFunctionUrl(
            local: "$baseUrl/fluttalk/us-central1/getNewMessages",
            prod: "https://getnewmessages$baseUrl",
            // https://getnewmessages-cwpwobd65q-uc.a.run.app
          ).getUrl(isLocal),
      };
}
