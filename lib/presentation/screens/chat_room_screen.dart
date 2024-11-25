import 'package:fluttalk/model/chat.dart';
import 'package:fluttalk/presentation/components/chat_list/chat_scroll_view.dart';
import 'package:fluttalk/presentation/components/chat_room/chat_room_message_text_field.dart';
import 'package:flutter/material.dart';

class ChatRoomScreen extends StatelessWidget {
  final Chat chat;
  const ChatRoomScreen({required this.chat, super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 56.0),
              child: ChatScrollView(),
            ),
            ChatRoomMessageTextField(),
          ],
        ),
      ),
    );
  }
}
