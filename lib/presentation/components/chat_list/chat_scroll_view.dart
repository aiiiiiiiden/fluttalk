import 'package:fluttalk/presentation/common/position_retained_scroll_physics.dart';
import 'package:fluttalk/presentation/components/chat_list/chat_messages_sliver_list.dart';
import 'package:fluttalk/presentation/inherited/chat_inherited_notifier.dart';
import 'package:fluttalk/presentation/components/chat_room/chat_room_sliver_app_bar.dart';
import 'package:flutter/material.dart';

class ChatScrollView extends StatefulWidget {
  const ChatScrollView({super.key});

  @override
  State<ChatScrollView> createState() => _ChatScrollViewState();
}

class _ChatScrollViewState extends State<ChatScrollView> {
  final _scrollController = ScrollController(keepScrollOffset: true);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_registerScrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final chatChangeNotifier = ChatInheritedNotifier.read(context);
      chatChangeNotifier.changedChat().listen((chat) async {
        await chatChangeNotifier.loadNewMessages();
        _scrollToBottom();
      });
    });
  }

  _registerScrollListener() async {
    final chatChangeNotifier = ChatInheritedNotifier.read(context);
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels == 0 &&
        chatChangeNotifier.canLoadMore) {
      await chatChangeNotifier.loadMore();
    }
  }

  _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_scrollController.hasClients) {
        await _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_registerScrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const PositionRetainedScrollPhysics(),
      controller: _scrollController,
      slivers: const [
        ChatRoomSliverAppBar(),
        ChatMessagesSliverList(),
      ],
    );
  }
}
