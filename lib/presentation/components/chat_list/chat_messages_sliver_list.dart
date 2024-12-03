import 'package:fluttalk/presentation/components/chat_room/chat_message_balloon.dart';
import 'package:fluttalk/presentation/inherited/chat_inherited_notifier.dart';
import 'package:fluttalk/presentation/inherited/user_inherited_notifier.dart';
import 'package:flutter/material.dart';

class ChatMessagesSliverList extends StatelessWidget {
  const ChatMessagesSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    final chatChangeNotifier = ChatInheritedNotifier.watch(context);
    final profileModel = UserInheritedNotifier.read(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: chatChangeNotifier.count,
        (context, index) {
          final message = chatChangeNotifier.get(index);
          if (message != null) {
            return ChatMessageBalloon(
              key: ValueKey(message.sentAt),
              message: message,
              isUsers: message.isUsers(profileModel.uid),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
