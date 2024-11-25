import 'package:fluttalk/model/chat_model.dart';
import 'package:flutter/material.dart';

class ChatModelNotifier extends InheritedNotifier<ChatModel> {
  const ChatModelNotifier({
    super.key,
    required super.notifier,
    required super.child,
  });

  static ChatModel watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ChatModelNotifier>()!
        .notifier!;
  }

  static ChatModel read(BuildContext context) {
    return context
        .findAncestorWidgetOfExactType<ChatModelNotifier>()!
        .notifier!;
  }
}
