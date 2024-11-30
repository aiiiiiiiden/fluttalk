import 'package:fluttalk/ambiguous/chat_change_notifier.dart';
import 'package:flutter/material.dart';

class ChatInheritedNotifier extends InheritedNotifier<ChatChangeNotifier> {
  const ChatInheritedNotifier({
    super.key,
    required super.notifier,
    required super.child,
  });

  static ChatChangeNotifier watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ChatInheritedNotifier>()!
        .notifier!;
  }

  static ChatChangeNotifier read(BuildContext context) {
    return context
        .findAncestorWidgetOfExactType<ChatInheritedNotifier>()!
        .notifier!;
  }
}
