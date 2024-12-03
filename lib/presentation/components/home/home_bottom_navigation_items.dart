import 'package:fluttalk/gen/assets.gen.dart';
import 'package:fluttalk/presentation/theme/my_colors.dart';
import 'package:flutter/material.dart';

enum HomeBottomNavigationItems {
  friendList,
  chatList,
  more,
}

extension BottomNavigationItemsExtension on HomeBottomNavigationItems {
  static HomeBottomNavigationItems fromIndex(int index) {
    if (index < 0 || index >= HomeBottomNavigationItems.values.length) {
      throw RangeError('Index $index is out of range');
    }
    return HomeBottomNavigationItems.values[index];
  }

  int get index => HomeBottomNavigationItems.values.indexOf(this);

  String get _title => {
        HomeBottomNavigationItems.friendList: "친구",
        HomeBottomNavigationItems.chatList: '대화',
        HomeBottomNavigationItems.more: '더 보기',
      }[this]!;

  AssetGenImage get _assetGenImage => {
        HomeBottomNavigationItems.friendList: Assets.icons.groupLight,
        HomeBottomNavigationItems.chatList: Assets.icons.messageCircleLight,
        HomeBottomNavigationItems.more: Assets.icons.hamburgerLight,
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
