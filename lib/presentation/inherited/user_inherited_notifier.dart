import 'package:fluttalk/ambiguous/user_change_notifier.dart';
import 'package:flutter/material.dart';

class UserInheritedNotifier extends InheritedNotifier<UserChangeNotifier> {
  const UserInheritedNotifier({
    super.key,
    required super.notifier,
    required super.child,
  });

  static UserChangeNotifier watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<UserInheritedNotifier>()!
        .notifier!;
  }

  static UserChangeNotifier read(BuildContext context) {
    return context
        .findAncestorWidgetOfExactType<UserInheritedNotifier>()!
        .notifier!;
  }
}
