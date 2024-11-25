import 'package:fluttalk/gen/assets.gen.dart';
import 'package:fluttalk/presentation/theme/my_colors.dart';
import 'package:flutter/material.dart';

enum BottomNavigationItems {
  friendList,
  chatList,
  more,
}

extension BottomNavigationItemsExtension on BottomNavigationItems {
  static BottomNavigationItems fromIndex(int index) {
    if (index < 0 || index >= BottomNavigationItems.values.length) {
      throw RangeError('Index $index is out of range');
    }
    return BottomNavigationItems.values[index];
  }

  int get index => BottomNavigationItems.values.indexOf(this);

  String get _title => {
        BottomNavigationItems.friendList: "친구",
        BottomNavigationItems.chatList: '대화',
        BottomNavigationItems.more: '더 보기',
      }[this]!;

  AssetGenImage get _assetGenImage => {
        BottomNavigationItems.friendList: Assets.icons.groupLight,
        BottomNavigationItems.chatList: Assets.icons.messageCircleLight,
        BottomNavigationItems.more: Assets.icons.hamburgerLight,
      }[this]!;

  BottomNavigationBarItem bottomNavigationBarItem({required bool isSelected}) {
    return BottomNavigationBarItem(
      label: _title,
      icon: _assetGenImage.image(
        scale: 2,
        color: isSelected ? MyColors.neutralActive : MyColors.neutralWeak,
      ),
    );
  }
}
