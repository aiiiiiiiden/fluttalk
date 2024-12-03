import 'package:fluttalk/presentation/components/home/home_bottom_navigation_items.dart';
import 'package:fluttalk/presentation/components/home/home_bottom_navigation_bar.dart';
import 'package:fluttalk/presentation/inherited/user_inherited_notifier.dart';
import 'package:fluttalk/presentation/screens/friend_list_screen.dart';
import 'package:fluttalk/presentation/screens/chat_list_screen.dart';
import 'package:fluttalk/presentation/screens/more_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final navigationItemNotifer =
      ValueNotifier(HomeBottomNavigationItems.friendList);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileModel = UserInheritedNotifier.read(context);
      profileModel.load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: HomeBottonNavigationBar(navigationItemNotifer),
      body: ValueListenableBuilder(
        valueListenable: navigationItemNotifer,
        builder: (context, value, child) => switch (value) {
          HomeBottomNavigationItems.friendList => const FriendListScreen(),
          HomeBottomNavigationItems.chatList => const ChatListScreen(),
          HomeBottomNavigationItems.more => const MoreScreen()
        },
      ),
    );
  }
}
