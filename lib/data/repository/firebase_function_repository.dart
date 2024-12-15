import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:fluttalk/data/reponse/chat_response.dart';
import 'package:fluttalk/data/reponse/chats_response.dart';
import 'package:fluttalk/data/reponse/message_response.dart';
import 'package:fluttalk/data/reponse/messages_response.dart';
import 'package:fluttalk/data/reponse/user_response.dart';
import 'package:fluttalk/data/reponse/users_response.dart';
import 'package:fluttalk/data/repository/firebase_function_config.dart';
import 'package:fluttalk/data/repository/repository.dart';

class FirebaseFunctionRepository implements Repository {
  final Dio dio;
  final FirebaseFunctionsConfig config;
  FirebaseFunctionRepository({
    required this.dio,
    required this.config,
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
      config.getUrl(FirebaseFunctions.addFriendsByEmail),
      options: await _getOptions(),
      data: {"email": email},
    );
    return UserResponse.fromJson(response.data);
  }

  Future<UserResponse> removeFriendByEmail(String email) async {
    final response = await dio.delete(
      config.getUrl(FirebaseFunctions.removeFriendByEmail),
      options: await _getOptions(),
      data: {"email": email},
    );
    return UserResponse.fromJson(response.data);
  }

  Future<UsersResponse> getFriends() async {
    final response = await dio.get(
      config.getUrl(FirebaseFunctions.getFriends),
      options: await _getOptions(),
    );
    return UsersResponse.fromJson(response.data);
  }

  Future<ChatsResponse> getChats({String? startAt}) async {
    final response = await dio.get(
      config.getUrl(FirebaseFunctions.getChats),
      queryParameters: startAt == null ? {} : {startAt: startAt},
      options: await _getOptions(),
    );
    return ChatsResponse.fromJson(response.data);
  }

  Future<ChatResponse> createChat(String email, String title) async {
    final response = await dio.post(
      config.getUrl(FirebaseFunctions.postChat),
      options: await _getOptions(),
      data: {"email": email, "title": title},
    );
    return ChatResponse.fromJson(response.data);
  }

  Future<UserResponse> getMe() async {
    final response = await dio.get(
      config.getUrl(FirebaseFunctions.getMe),
      options: await _getOptions(),
    );
    return UserResponse.fromJson(response.data);
  }

  Future<UserResponse> updateMe(String name) async {
    final response = await dio.post(
      config.getUrl(FirebaseFunctions.postMe),
      options: await _getOptions(),
      data: {"name": name},
    );
    return UserResponse.fromJson(response.data);
  }

  Future<MessageResponse> sendMessage(String chatId, String content) async {
    final response = await dio.post(
      config.getUrl(FirebaseFunctions.sendMessage),
      options: await _getOptions(),
      data: {"chatId": chatId, "content": content},
    );
    return MessageResponse.fromJson(response.data);
  }

  Future<MessagesResponse> getMessages(String chatId, {String? startAt}) async {
    final response = await dio.get(
      config.getUrl(FirebaseFunctions.getMessages),
      options: await _getOptions(),
      queryParameters: {
        "chatId": chatId,
        if (startAt != null) "startAt": startAt
      },
    );
    return MessagesResponse.fromJson(response.data);
  }

  Future<MessagesResponse> getNewMessages({
    required String chatId,
    required int lastNewestSentAt,
  }) async {
    final response = await dio.get(
      config.getUrl(FirebaseFunctions.getLatestMessages),
      options: await _getOptions(),
      queryParameters: {"chatId": chatId, "lastNewestSentAt": lastNewestSentAt},
    );
    return MessagesResponse.fromJson(response.data);
  }

  Future<void> registerPushToken({required String pushToken}) async {
    await dio.post(
      config.getUrl(FirebaseFunctions.postPushToken),
      options: await _getOptions(),
      data: {"pushToken": pushToken},
    );
  }
}
