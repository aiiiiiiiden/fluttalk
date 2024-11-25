import 'package:fluttalk/model/profile_model.dart';
import 'package:flutter/material.dart';

class ProfileModelNotifier extends InheritedNotifier<ProfileModel> {
  const ProfileModelNotifier({
    super.key,
    required super.notifier,
    required super.child,
  });

  static ProfileModel watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProfileModelNotifier>()!
        .notifier!;
  }

  static ProfileModel read(BuildContext context) {
    return context
        .findAncestorWidgetOfExactType<ProfileModelNotifier>()!
        .notifier!;
  }
}
