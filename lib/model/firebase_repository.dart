import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:fluttalk/model/chat_response.dart';
import 'package:fluttalk/model/chats_response.dart';
import 'package:fluttalk/model/user_response.dart';
import 'package:fluttalk/model/users_response.dart';

class UrlHolder {
  final String local;
  final String prod;
  UrlHolder({
    required this.local,
    required this.prod,
  });

  getUrl(bool isLocal) => isLocal ? local : prod;
}

enum UrlTypes {
  removeFriendByEmail,
  getFriends,
  addFriendsByEmail,
  getChats,
  createChat,
  getMe,
  updateMe,
}

class UrlConfig {
  final bool isLocal;
  UrlConfig({required this.isLocal});

  final Map<UrlTypes, UrlHolder> urls = {
    UrlTypes.addFriendsByEmail: UrlHolder(
      local: "http://127.0.0.1:5001/fluttalk/us-central1/addFriendByEmail",
      prod: "https://addfriendbyemail-cwpwobd65q-uc.a.run.app",
    ),
    UrlTypes.removeFriendByEmail: UrlHolder(
      local: "http://127.0.0.1:5001/fluttalk/us-central1/removeFriendByEmail",
      prod: "https://removefriendbyemail-cwpwobd65q-uc.a.run.app",
    ),
    UrlTypes.getFriends: UrlHolder(
      local: "http://127.0.0.1:5001/fluttalk/us-central1/getFriends",
      prod: "https://getfriends-cwpwobd65q-uc.a.run.app",
    ),
    UrlTypes.getChats: UrlHolder(
      local: "http://127.0.0.1:5001/fluttalk/us-central1/getChats",
      prod: "https://getchats-cwpwobd65q-uc.a.run.app",
    ),
    UrlTypes.createChat: UrlHolder(
      local: "http://127.0.0.1:5001/fluttalk/us-central1/createChat",
      prod: "https://createchat-cwpwobd65q-uc.a.run.app",
    ),
    UrlTypes.getMe: UrlHolder(
      local: "http://127.0.0.1:5001/fluttalk/us-central1/getMe",
      prod: "https://getme-cwpwobd65q-uc.a.run.app",
    ),
    UrlTypes.updateMe: UrlHolder(
      local: "http://127.0.0.1:5001/fluttalk/us-central1/updateMe",
      prod: "https://updateme-cwpwobd65q-uc.a.run.app",
    ),
  };
  String getUrl(UrlTypes type) => urls[type]?.getUrl(isLocal);
}

class FirebaseRepository {
  final Dio dio;
  final UrlConfig urlConfig;
  FirebaseRepository({
    required this.dio,
    required this.urlConfig,
  });

  _getOptions() async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    return Options(
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json'
      },
    );
  }

  Future<UserResponse> addFriendByEmail(String email) async {
    final response = await dio.post(
      urlConfig.getUrl(UrlTypes.addFriendsByEmail),
      options: await _getOptions(),
      data: {"email": email},
    );
    return UserResponse.fromJson(response.data);
  }

  Future<UserResponse> removeFriendByEmail(String email) async {
    final response = await dio.post(
      urlConfig.getUrl(UrlTypes.removeFriendByEmail),
      options: await _getOptions(),
      data: {"email": email},
    );
    return UserResponse.fromJson(response.data);
  }

  Future<UsersResponse> getFriends() async {
    final response = await dio.get(
      urlConfig.getUrl(UrlTypes.getFriends),
      options: await _getOptions(),
    );
    return UsersResponse.fromJson(response.data);
  }

  Future<ChatsResponse> getChats({String? startAt}) async {
    final response = await dio.get(
      urlConfig.getUrl(UrlTypes.getChats),
      queryParameters: startAt == null ? {} : {startAt: startAt},
      options: await _getOptions(),
    );
    return ChatsResponse.fromJson(response.data);
  }

  Future<ChatResponse> createChat(String email, String title) async {
    final response = await dio.post(
      urlConfig.getUrl(UrlTypes.createChat),
      options: await _getOptions(),
      data: {"email": email, "title": title},
    );
    return ChatResponse.fromJson(response.data);
  }

  Future<UserResponse> getMe() async {
    final response = await dio.get(
      urlConfig.getUrl(UrlTypes.getMe),
      options: await _getOptions(),
    );
    return UserResponse.fromJson(response.data);
  }

  Future<UserResponse> updateMe(String name) async {
    final response = await dio.post(
      urlConfig.getUrl(UrlTypes.updateMe),
      options: await _getOptions(),
      data: {"name": name},
    );
    return UserResponse.fromJson(response.data);
  }
}
