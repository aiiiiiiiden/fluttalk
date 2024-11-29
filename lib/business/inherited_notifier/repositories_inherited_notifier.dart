import 'package:fluttalk/data/repository/repository.dart';
import 'package:fluttalk/business/change_notifier/repositories_change_notifier.dart';
import 'package:flutter/material.dart';

class RepositoriesInheritedNotifier
    extends InheritedNotifier<RepositoriesChangeNotifier> {
  const RepositoriesInheritedNotifier({
    super.key,
    required super.notifier,
    required super.child,
  });

  static T get<T extends Repository>(BuildContext context) {
    return context
        .findAncestorWidgetOfExactType<RepositoriesInheritedNotifier>()!
        .notifier!
        .repositories
        .firstWhere((repo) => repo is T) as T;
  }
}
