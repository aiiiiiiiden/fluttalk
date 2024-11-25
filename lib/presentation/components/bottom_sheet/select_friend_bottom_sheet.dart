import 'package:fluttalk/presentation/components/bottom_sheet/custom_sliver_header_delegate.dart';
import 'package:fluttalk/presentation/components/friend_list/friend_list_item.dart';
import 'package:fluttalk/presentation/notifiers/friends_model_notifier.dart';
import 'package:fluttalk/presentation/theme/my_colors.dart';
import 'package:fluttalk/presentation/theme/my_text_styles.dart';
import 'package:flutter/material.dart';

class SelectFriendBottomSheet extends StatelessWidget {
  const SelectFriendBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final friendsModel = FriendsModelNotifier.watch(context);
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: CustomSliverHeaderDelegate(
            widget: Text(
              "채팅을 시작할 친구를 선택하세요",
              style: MyTextStyles.subheading2.copyWith(
                color: MyColors.neutralActive,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: friendsModel.friendsCount,
            (_, index) => FriendListItem(
              user: friendsModel.get(index),
              onTap: (user) => Navigator.of(context).pop(user),
            ),
          ),
        ),
        if (friendsModel.isLoaded && friendsModel.isNotExist)
          const SliverFillRemaining(
            child: Center(
              child: Text("친구가 없습니다"),
            ),
          ),
      ],
    );
  }
}
