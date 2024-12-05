// import 'package:firebase_ui_auth/firebase_ui_auth.dart' hide ProfileScreen;
import 'package:fluttalk/gen/assets.gen.dart';
import 'package:fluttalk/presentation/inherited/user_inherited_notifier.dart';
import 'package:fluttalk/presentation/components/common/item_titles.dart';
import 'package:fluttalk/presentation/screens/profile_screen.dart';
import 'package:fluttalk/presentation/theme/my_colors.dart';
import 'package:flutter/material.dart';

class MoreUserItem extends StatelessWidget {
  const MoreUserItem({super.key});

  @override
  Widget build(BuildContext context) {
    final userChangeNotifier = UserInheritedNotifier.watch(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: MyColors.neutralLine,
              ),
              child: Center(
                child: Assets.icons.user.image(scale: 2),
              ),
            ),
            const SizedBox(width: 16),
            ItemTitles(
              main: userChangeNotifier.email,
              sub: userChangeNotifier.name,
            ),
            const SizedBox(width: 6),
            InkWell(
              child: Assets.icons.chevronRight.image(scale: 2),
            )
          ],
        ),
      ),
    );
  }
}
