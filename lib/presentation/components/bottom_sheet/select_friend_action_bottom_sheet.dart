import 'package:fluttalk/data/user.dart';
import 'package:fluttalk/presentation/common/enums.dart';
import 'package:fluttalk/presentation/components/bottom_sheet/custom_sliver_header_delegate.dart';
import 'package:fluttalk/presentation/components/common/custom_button.dart';
import 'package:fluttalk/presentation/theme/my_colors.dart';
import 'package:fluttalk/presentation/theme/my_text_styles.dart';
import 'package:flutter/material.dart';

class SelectFriendActionBottomSheet extends StatelessWidget {
  final User user;
  const SelectFriendActionBottomSheet({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            delegate: CustomSliverHeaderDelegate(
              widget: Text(
                user.displayName.isNotEmpty ? user.displayName : user.email,
                style: MyTextStyles.subheading2.copyWith(
                  color: MyColors.neutralActive,
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  CustomButton(
                    onTap: () => Navigator.of(context).pop(FriendAction.chat),
                    isPrimary: true,
                    title: "대화 하기",
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    onTap: () => Navigator.of(context).pop(FriendAction.delete),
                    isPrimary: false,
                    title: "친구 끊기",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
