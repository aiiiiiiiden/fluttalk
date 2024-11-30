import 'package:fluttalk/data/chat.dart';
import 'package:fluttalk/data/user.dart';
import 'package:fluttalk/data/repository/firebase_function_repository.dart';
import 'package:fluttalk/ambiguous/repositories_inherited_model.dart';
import 'package:fluttalk/ambiguous/chat_change_notifier.dart';
import 'package:fluttalk/presentation/inherited/chats_inherited_notifier.dart';
import 'package:fluttalk/presentation/components/chat_list/chat_list_item.dart';
import 'package:fluttalk/presentation/components/chat_list/chat_list_sliver_app_bar.dart';
import 'package:fluttalk/presentation/components/common/search_text_field.dart';
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
  final textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ChatsInheritedNotifier.read(context).load();
    });
  }

  _onSelect(BuildContext context, Chat chat) async {
    final chatChangeNotifier = await ChatChangeNotifier.create(
      chat,
      RepositoriesInheritedModel.of<FirebaseFunctionRepository>(context),
    );
    if (context.mounted) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return ChatRoomScreen(
            chatChangeNotifier: chatChangeNotifier,
          );
        },
      ));
    }
  }

  _createChat(BuildContext context, User user, String title) async {
    final chatChangeNotifier =
        await ChatsInheritedNotifier.read(context).create(user, title);
    if (context.mounted) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ChatRoomScreen(
          chatChangeNotifier: chatChangeNotifier,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatsChangeNotifier = ChatsInheritedNotifier.watch(context);
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
                  controller: textEditingController,
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 16,
                    bottom: 8,
                  ),
                ),
              _ => ChatListItem(
                  chat: chatsChangeNotifier.get(index - 1),
                  onTap: (chat) => _onSelect(context, chat),
                ),
            },
            childCount: chatsChangeNotifier.chatsCount + 1,
          ),
        ),
        if (chatsChangeNotifier.isNotExist)
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
