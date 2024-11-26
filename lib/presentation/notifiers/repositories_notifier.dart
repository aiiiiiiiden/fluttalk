import 'package:flutter/material.dart';

abstract class Repository {}

class Repositories extends ChangeNotifier {
  final List<Repository> repositories;
  Repositories({required this.repositories});

  T get<T extends Repository>() {
    return repositories.firstWhere((repo) => repo is T) as T;
  }
}

class RepositoriesNotifier extends InheritedNotifier<Repositories> {
  const RepositoriesNotifier({
    super.key,
    required super.notifier,
    required super.child,
  });

  static Repositories read(BuildContext context) {
    return context
        .findAncestorWidgetOfExactType<RepositoriesNotifier>()!
        .notifier!;
  }
}
