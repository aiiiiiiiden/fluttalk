import 'dart:math';

import 'package:fluttalk/presentation/components/chat_room/chat_message_balloon.dart';
import 'package:fluttalk/presentation/components/chat_room/chat_room_sliver_app_bar.dart';
import 'package:fluttalk/presentation/notifiers/chat_model_notifier.dart';
import 'package:flutter/material.dart';

class ChatScrollView extends StatelessWidget {
  const ChatScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    final chatModel = ChatModelNotifier.watch(context);
    return CustomScrollView(
      slivers: [
        const ChatRoomSliverAppBar(),
        SliverList.builder(
          itemBuilder: (context, index) {
            return ChatMessageBalloon(
              message: chatModel.get(index),
              isUsers: Random().nextBool(),
            );
          },
          itemCount: chatModel.count,
        ),
      ],
    );
  }
}
