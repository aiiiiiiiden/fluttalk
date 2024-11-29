import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttalk/firebase_options.dart';
import 'package:fluttalk/data/repository/firebase_function_config.dart';
import 'package:fluttalk/business/change_notifier/chats_change_notifier.dart';
import 'package:fluttalk/data/repository/firebase_function_repository.dart';
import 'package:fluttalk/business/change_notifier/friends_change_notifier.dart';
import 'package:fluttalk/business/change_notifier/repositories_change_notifier.dart';
import 'package:fluttalk/business/change_notifier/user_change_notifier.dart';
import 'package:fluttalk/business/inherited_notifier/chats_inherited_notifier.dart';
import 'package:fluttalk/business/inherited_notifier/friends_inherited_notifier.dart';
import 'package:fluttalk/business/inherited_notifier/user_inherited_notifier.dart';
import 'package:fluttalk/business/inherited_notifier/repositories_inherited_notifier.dart';
import 'package:fluttalk/presentation/screens/auth_state_screen.dart';
import 'package:fluttalk/presentation/screens/welcome_screen.dart';
import 'package:fluttalk/presentation/theme/my_theme.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseFunctionRepository = FirebaseFunctionRepository(
      dio: Dio(),
      config: FirebaseFunctionsConfig(isLocal: false),
    );

    return RepositoriesInheritedNotifier(
      notifier: RepositoriesChangeNotifier(
          repositories: [firebaseFunctionRepository]),
      child: UserInheritedNotifier(
        notifier: UserChangeNotifier(repository: firebaseFunctionRepository),
        child: FriendsInheritedNotifier(
          notifier:
              FriendsChangeNotifier(repository: firebaseFunctionRepository),
          child: ChatsInheritedNotifier(
            notifier:
                ChatsChangeNotifier(repository: firebaseFunctionRepository),
            child: MaterialApp(
              theme: MyTheme.light(),
              debugShowCheckedModeBanner: false,
              home: FirebaseAuth.instance.currentUser != null
                  ? const AuthStateScreen()
                  : const WelcomeScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
