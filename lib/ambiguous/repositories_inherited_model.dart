import 'package:fluttalk/data/repository/repository.dart';
import 'package:flutter/material.dart';

class RepositoriesInheritedModel extends InheritedModel<Repository> {
  final List<Repository> repositories;
  const RepositoriesInheritedModel({
    super.key,
    required this.repositories,
    required super.child,
  });
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return (oldWidget is RepositoriesInheritedModel &&
        oldWidget.repositories != repositories);
  }

  @override
  bool updateShouldNotifyDependent(
      covariant InheritedModel<Repository> oldWidget,
      Set<Repository> dependencies) {
    for (final dependency in dependencies) {
      if (oldWidget is RepositoriesInheritedModel) {
        if (oldWidget.repositories.contains(dependency) &&
            !repositories.contains(dependency)) {
          return true;
        }
      }
    }
    return false;
  }

  static T of<T extends Repository>(BuildContext context) {
    final inheritedModel =
        InheritedModel.inheritFrom<RepositoriesInheritedModel>(context);
    return inheritedModel?.repositories.firstWhere(
      (repository) => repository is T,
      orElse: () => throw StateError('$T 유형의 Repository를 찾을 수 없습니다'),
    ) as T;
  }
}
