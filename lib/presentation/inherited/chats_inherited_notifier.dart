import 'package:fluttalk/ambiguous/chats_change_notifier.dart';
import 'package:flutter/material.dart';

class ChatsInheritedNotifier extends InheritedNotifier<ChatsChangeNotifier> {
  const ChatsInheritedNotifier({
    super.key,
    required super.notifier,
    required super.child,
  });

  static ChatsChangeNotifier watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ChatsInheritedNotifier>()!
        .notifier!;
  }

  static ChatsChangeNotifier read(BuildContext context) {
    return context
        .findAncestorWidgetOfExactType<ChatsInheritedNotifier>()!
        .notifier!;
  }
}
