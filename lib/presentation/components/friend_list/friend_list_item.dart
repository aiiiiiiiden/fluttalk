import 'package:fluttalk/common/utility.dart';
import 'package:fluttalk/data/user.dart';
import 'package:fluttalk/presentation/components/common/item_titles.dart';
import 'package:fluttalk/presentation/components/common/profile_thumbnail.dart';
import 'package:fluttalk/presentation/theme/my_colors.dart';
import 'package:flutter/material.dart';

class FriendListItem extends StatelessWidget {
  final User user;
  final Function(User user) onTap;
  const FriendListItem({
    required this.user,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap(user),
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
                    main: user.email,
                    sub: user.lastSignInTime.differentTimeDisplayText,
                  ),
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
      ),
    );
  }
}
