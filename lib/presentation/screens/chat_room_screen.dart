import 'package:fluttalk/model/chat.dart';
import 'package:fluttalk/model/chat_model.dart';
import 'package:fluttalk/model/firebase_repository.dart';
import 'package:fluttalk/presentation/components/chat_list/chat_scroll_view.dart';
import 'package:fluttalk/presentation/components/chat_room/chat_room_message_text_field.dart';
import 'package:fluttalk/presentation/notifiers/chat_model_notifier.dart';
import 'package:fluttalk/presentation/notifiers/repositories_notifier.dart';
import 'package:flutter/material.dart';

class ChatRoomScreen extends StatelessWidget {
  final Chat chat;
  const ChatRoomScreen({required this.chat, super.key});

  @override
  Widget build(BuildContext context) {
    final repositories = RepositoriesNotifier.read(context);
    final firebaseRepository = repositories.get<FirebaseRepository>();
    return ChatModelNotifier(
      notifier: ChatModel(repository: firebaseRepository),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 56.0),
                child: ChatScrollView(),
              ),
              ChatRoomMessageTextField(chat: chat),
            ],
          ),
        ),
      ),
    );
  }
}
