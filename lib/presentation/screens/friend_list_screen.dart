import 'package:fluttalk/data/user.dart';
import 'package:fluttalk/business/inherited_notifier/chats_inherited_notifier.dart';
import 'package:fluttalk/business/inherited_notifier/friends_inherited_notifier.dart';
import 'package:fluttalk/presentation/common/enums.dart';
import 'package:fluttalk/presentation/components/bottom_sheet/edit_chat_title_bottom_sheet.dart';
import 'package:fluttalk/presentation/components/bottom_sheet/select_friend_action_bottom_sheet.dart';
import 'package:fluttalk/presentation/components/friend_list/friend_list_item.dart';
import 'package:fluttalk/presentation/components/common/search_text_field.dart';
import 'package:fluttalk/presentation/components/friend_list/friend_list_sliver_app_bar.dart';
import 'package:fluttalk/presentation/screens/chat_room_screen.dart';
import 'package:fluttalk/presentation/theme/my_colors.dart';
import 'package:fluttalk/presentation/theme/my_text_styles.dart';
import 'package:flutter/material.dart';

class FriendListScreen extends StatefulWidget {
  const FriendListScreen({super.key});

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  final textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FriendsInheritedNotifier.read(context).load();
    });
  }

  _showChatRoom(BuildContext context, User user) async {
    final result = await showModalBottomSheet<FriendAction>(
      context: context,
      isScrollControlled: false,
      builder: (bottomSheetContext) =>
          SelectFriendActionBottomSheet(user: user),
    );
    if (result == FriendAction.delete && context.mounted) {
      final friendsChangeNotifier = FriendsInheritedNotifier.read(context);
      await friendsChangeNotifier.remove(user.email);
    } else if (result == FriendAction.chat && context.mounted) {
      final title = await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: false,
        builder: (bottomSheetContext) => const EditChatTitleBottomSheet(),
      );
      if (title != null && context.mounted) {
        await _createChat(context, user, title);
      }
    }
  }

  _createChat(BuildContext context, User user, String title) async {
    final chatsChangeNotifier = ChatsInheritedNotifier.read(context);
    final chatChangeNotifier = await chatsChangeNotifier.create(user, title);
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
    final friendsChangeNotifier = FriendsInheritedNotifier.watch(context);
    return CustomScrollView(
      slivers: [
        const FriendListSliverAppBar(),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) => switch (index) {
              0 => SearchTextField(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 16, bottom: 8),
                  placeholder: "검색할 친구 정보를 입력하세요.",
                  controller: textEditingController,
                ),
              _ => FriendListItem(
                  user: friendsChangeNotifier.get(index - 1),
                  onTap: (user) => _showChatRoom(context, user),
                ),
            },
            childCount: friendsChangeNotifier.friendsCount + 1,
          ),
        ),
        if (friendsChangeNotifier.isLoaded && friendsChangeNotifier.isNotExist)
          SliverFillRemaining(
            child: Center(
              child: Text(
                "친구가 없습니다",
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
