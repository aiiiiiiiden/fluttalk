import 'package:fluttalk/data/chat.dart';
import 'package:fluttalk/presentation/components/common/item_titles.dart';
import 'package:fluttalk/presentation/components/chat_list/chat_list_item_metadata.dart';
import 'package:fluttalk/presentation/components/common/profile_thumbnail.dart';
import 'package:fluttalk/presentation/theme/my_colors.dart';
import 'package:flutter/material.dart';

class ChatListItem extends StatelessWidget {
  final Chat chat;
  final Function(Chat chat) onTap;

  const ChatListItem({
    required this.chat,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(chat),
      child: Container(
        padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ProfileThumbnail(),
                const SizedBox(width: 12),
                ItemTitles(
                  main: chat.title,
                  sub: chat.lastMessageContent,
                ),
                const SizedBox(width: 4),
                ChatListItemMetadata(chat: chat),
              ],
            ),
            const SizedBox(height: 12.5),
            Container(
              height: 1,
              color: MyColors.neutralLine,
            ),
          ],
        ),
      ),
    );
  }
}
