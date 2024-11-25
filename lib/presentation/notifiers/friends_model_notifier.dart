import 'package:fluttalk/model/friends_model.dart';
import 'package:flutter/material.dart';

class FriendsModelNotifier extends InheritedNotifier<FriendsModel> {
  const FriendsModelNotifier({
    super.key,
    required super.notifier,
    required super.child,
  });

  static FriendsModel watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<FriendsModelNotifier>()!
        .notifier!;
  }

  static FriendsModel read(BuildContext context) {
    return context
        .findAncestorWidgetOfExactType<FriendsModelNotifier>()!
        .notifier!;
  }
}
