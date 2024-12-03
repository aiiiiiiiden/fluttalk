import 'package:fluttalk/common/utility.dart';
import 'package:fluttalk/data/chat.dart';
import 'package:fluttalk/presentation/theme/my_colors.dart';
import 'package:fluttalk/presentation/theme/my_text_styles.dart';
import 'package:flutter/material.dart';

class ChatListItemMetadata extends StatelessWidget {
  final Chat chat;
  const ChatListItemMetadata({
    required this.chat,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            chat.updatedAt.differentTimeDisplayText,
            style: MyTextStyles.metaData2.copyWith(
              color: MyColors.neutralWeak,
            ),
          ),
        ],
      ),
    );
  }
}
