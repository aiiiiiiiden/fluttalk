import 'package:fluttalk/business/change_notifier/chat_change_notifier.dart';
import 'package:fluttalk/business/inherited_notifier/chat_inherited_notifier.dart';
import 'package:fluttalk/presentation/components/chat_list/chat_scroll_view.dart';
import 'package:fluttalk/presentation/components/chat_room/chat_room_message_text_field.dart';
import 'package:flutter/material.dart';

class ChatRoomScreen extends StatelessWidget {
  final ChatChangeNotifier chatChangeNotifier;
  const ChatRoomScreen({required this.chatChangeNotifier, super.key});

  @override
  Widget build(BuildContext context) {
    return ChatInheritedNotifier(
      notifier: chatChangeNotifier,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 56.0),
                child: ChatScrollView(),
              ),
              ChatRoomMessageTextField(chat: chatChangeNotifier.chat),
            ],
          ),
        ),
      ),
    );
  }
}
