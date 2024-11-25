import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttalk/firebase_options.dart';
import 'package:fluttalk/model/chats_model.dart';
import 'package:fluttalk/model/firebase_repository.dart';
import 'package:fluttalk/model/friends_model.dart';
import 'package:fluttalk/model/profile_model.dart';
import 'package:fluttalk/presentation/notifiers/chats_model_notifier.dart';
import 'package:fluttalk/presentation/notifiers/friends_model_notifier.dart';
import 'package:fluttalk/presentation/notifiers/profile_model_notifier.dart';
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
    final firebaseRepository = FirebaseRepository(
      dio: Dio(),
      urlConfig: UrlConfig(isLocal: false),
    );

    return ProfileModelNotifier(
      notifier: ProfileModel(repository: firebaseRepository),
      child: FriendsModelNotifier(
        notifier: FriendsModel(repository: firebaseRepository),
        child: ChatsModelNotifier(
          notifier: ChatsModel(repository: firebaseRepository),
          child: MaterialApp(
            theme: MyTheme.light(),
            debugShowCheckedModeBanner: false,
            home: FirebaseAuth.instance.currentUser != null
                ? const AuthStateScreen()
                : const WelcomeScreen(),
          ),
        ),
      ),
    );
  }
}
