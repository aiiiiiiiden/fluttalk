import 'package:fluttalk/ambiguous/friends_change_notifier.dart';
import 'package:flutter/material.dart';

class FriendsInheritedNotifier
    extends InheritedNotifier<FriendsChangeNotifier> {
  const FriendsInheritedNotifier({
    super.key,
    required super.notifier,
    required super.child,
  });

  static FriendsChangeNotifier watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<FriendsInheritedNotifier>()!
        .notifier!;
  }

  static FriendsChangeNotifier read(BuildContext context) {
    return context
        .findAncestorWidgetOfExactType<FriendsInheritedNotifier>()!
        .notifier!;
  }
}
