import 'package:fluttalk/gen/assets.gen.dart';

enum MoreGroupsChild {
  privacy,
  help,
}

sealed class MoreItemData {}

class MoreUserItemData implements MoreItemData {
  const MoreUserItemData();
}

class MoreGroupItemData implements MoreItemData {
  final List<MoreGroupsChild> children;
  const MoreGroupItemData({required this.children});
}

class MoreSeperatorItemData implements MoreItemData {}

class MoreLogoutItemData implements MoreItemData {}

extension MoreGroupChildsExtension on MoreGroupsChild {
  String get title => {
        MoreGroupsChild.privacy: '개인 정보 처리 방침',
        MoreGroupsChild.help: '도움말',
      }[this]!;

  AssetGenImage get assetGenImage => {
        MoreGroupsChild.privacy: Assets.icons.outlinePrivacyTip,
        MoreGroupsChild.help: Assets.icons.helpCircle,
      }[this]!;
}
