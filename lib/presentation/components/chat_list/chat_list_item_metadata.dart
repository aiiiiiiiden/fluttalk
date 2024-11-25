import 'package:fluttalk/common/utility.dart';
import 'package:fluttalk/model/chat.dart';
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
          // TODO: 안 읽은 메시지 갯수는 로컬스토리지 구현 후 표시
          // Container(
          //   width: 20,
          //   height: 20,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(40),
          //     color: MyColors.brandBG,
          //   ),
          //   child: Center(
          //     child: Text(
          //       "99",
          //       style: MyTextStyles.metaData2.copyWith(
          //         color: MyColors.brandDark,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
