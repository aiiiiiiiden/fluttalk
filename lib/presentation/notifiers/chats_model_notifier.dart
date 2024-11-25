import 'package:fluttalk/model/chats_model.dart';
import 'package:flutter/material.dart';

class ChatsModelNotifier extends InheritedNotifier<ChatsModel> {
  const ChatsModelNotifier({
    super.key,
    required super.notifier,
    required super.child,
  });

  static ChatsModel watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ChatsModelNotifier>()!
        .notifier!;
  }

  static ChatsModel read(BuildContext context) {
    return context
        .findAncestorWidgetOfExactType<ChatsModelNotifier>()!
        .notifier!;
  }
}
