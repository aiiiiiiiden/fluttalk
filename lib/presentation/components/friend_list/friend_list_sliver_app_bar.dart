import 'package:fluttalk/gen/assets.gen.dart';
import 'package:fluttalk/presentation/components/bottom_sheet/add_friend_bottom_sheet.dart';
import 'package:fluttalk/presentation/theme/my_colors.dart';
import 'package:fluttalk/presentation/theme/my_text_styles.dart';
import 'package:flutter/material.dart';

class FriendListSliverAppBar extends StatelessWidget {
  const FriendListSliverAppBar({super.key});

  _showAddFriendBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (bottomSheetContext) => const AddFriendBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: MyColors.neutralWhite,
      title: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          "친구",
          style: MyTextStyles.subheading1.copyWith(
            color: MyColors.neutralActive,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16, bottom: 8),
          child: InkWell(
            onTap: () => _showAddFriendBottomSheet(context),
            child: Assets.icons.plus.image(
              scale: 2,
              color: MyColors.neutralActive,
            ),
          ),
        ),
      ],
      scrolledUnderElevation: 0,
      centerTitle: false,
      pinned: true,
    );
  }
}
