import 'package:flutter/material.dart';

class LoadMoreController extends ChangeNotifier {
  invoke() {
    notifyListeners();
  }
}

class LoadMore extends StatefulWidget {
  final LoadMoreController controller;
  const LoadMore({
    super.key,
    required this.controller,
  });

  @override
  State<LoadMore> createState() => _LoadMoreState();
}

class _LoadMoreState extends State<LoadMore> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.controller.invoke();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 80,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
