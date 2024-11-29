import 'package:fluttalk/data/repository/repository.dart';
import 'package:flutter/material.dart';

class RepositoriesChangeNotifier extends ChangeNotifier {
  final List<Repository> repositories;
  RepositoriesChangeNotifier({required this.repositories});

  T get<T extends Repository>() {
    return repositories.firstWhere((repository) => repository is T) as T;
  }
}
