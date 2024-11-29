import 'package:fluttalk/business/inherited_notifier/chat_inherited_notifier.dart';
import 'package:fluttalk/business/inherited_notifier/user_inherited_notifier.dart';
import 'package:fluttalk/presentation/components/chat_room/chat_message_balloon.dart';
import 'package:fluttalk/presentation/components/chat_room/chat_room_sliver_app_bar.dart';
import 'package:flutter/material.dart';

class ChatScrollView extends StatefulWidget {
  const ChatScrollView({super.key});

  @override
  State<ChatScrollView> createState() => _ChatScrollViewState();
}

class _ChatScrollViewState extends State<ChatScrollView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      final chatChangeNotifier = ChatInheritedNotifier.read(context);
      _scrollController.addListener(() {
        chatChangeNotifier.loadMore();
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatChangeNotifier = ChatInheritedNotifier.watch(context);
    final profileModel = UserInheritedNotifier.watch(context);
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        const ChatRoomSliverAppBar(),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: chatChangeNotifier.count,
            (context, index) {
              final message = chatChangeNotifier.get(index);
              return ChatMessageBalloon(
                key: ValueKey(message.sentAt),
                message: message,
                isUsers: message.isUsers(profileModel.uid),
              );
            },
          ),
        ),
      ],
    );
  }
}
