import 'package:fluttalk/model/chat.dart';
import 'package:fluttalk/model/user.dart';
import 'package:fluttalk/presentation/components/chat_list/chat_list_item.dart';
import 'package:fluttalk/presentation/components/chat_list/chat_list_sliver_app_bar.dart';
import 'package:fluttalk/presentation/components/common/search_text_field.dart';
import 'package:fluttalk/presentation/notifiers/chats_model_notifier.dart';
import 'package:fluttalk/presentation/screens/chat_room_screen.dart';
import 'package:fluttalk/presentation/theme/my_colors.dart';
import 'package:fluttalk/presentation/theme/my_text_styles.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final chatsModel = ChatsModelNotifier.read(context);
      chatsModel.load();
    });
  }

  _onSelect(BuildContext context, Chat chat) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ChatRoomScreen(chat: chat),
    ));
  }

  _createChat(BuildContext context, User user, String title) async {
    final chatsModel = ChatsModelNotifier.read(context);
    final createdChat = await chatsModel.create(user, title);
    if (context.mounted) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ChatRoomScreen(chat: createdChat),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatsModel = ChatsModelNotifier.watch(context);
    return CustomScrollView(
      slivers: [
        ChatListSliverAppBar(
          onCreateChat: (user, title) => _createChat(
            context,
            user,
            title,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) => switch (index) {
              0 => SearchTextField(
                  placeholder: "검색할 채팅방 정보를 입력하세요.",
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 16,
                    bottom: 8,
                  ),
                  onChangedText: (text) {},
                ),
              _ => ChatListItem(
                  chat: chatsModel.get(index - 1),
                  onTap: (chat) => _onSelect(context, chat),
                ),
            },
            childCount: chatsModel.chatsCount + 1,
          ),
        ),
        if (chatsModel.isLoaded && chatsModel.isNotExist)
          SliverFillRemaining(
            child: Center(
              child: Text(
                "생성된 채팅방이 없습니다",
                style: MyTextStyles.bodyText1.copyWith(
                  color: MyColors.neutralWeak,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
