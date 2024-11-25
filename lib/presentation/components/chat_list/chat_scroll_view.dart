import 'dart:math';

import 'package:fluttalk/presentation/components/chat_room/chat_message_balloon.dart';
import 'package:fluttalk/presentation/components/chat_room/chat_room_sliver_app_bar.dart';
import 'package:flutter/material.dart';

class ChatScrollView extends StatelessWidget {
  const ChatScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const ChatRoomSliverAppBar(),
        SliverList.builder(
          itemBuilder: (context, index) {
            return ChatMessageBalloon(
              isUsers: Random().nextBool(),
            );
          },
          itemCount: 60,
        ),
      ],
    );
  }
}
