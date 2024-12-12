import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttalk/ambiguous/dio_interceptors.dart';
import 'package:fluttalk/data/repository/firebase_firestore_repository.dart';
import 'package:fluttalk/firebase_options.dart';
import 'package:fluttalk/data/repository/firebase_function_config.dart';
import 'package:fluttalk/data/repository/firebase_function_repository.dart';
import 'package:fluttalk/ambiguous/chats_change_notifier.dart';
import 'package:fluttalk/ambiguous/friends_change_notifier.dart';
import 'package:fluttalk/ambiguous/repositories_inherited_model.dart';
import 'package:fluttalk/ambiguous/user_change_notifier.dart';
import 'package:fluttalk/presentation/inherited/chats_inherited_notifier.dart';
import 'package:fluttalk/presentation/inherited/friends_inherited_notifier.dart';
import 'package:fluttalk/presentation/inherited/user_inherited_notifier.dart';
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
    final dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    final functions = FirebaseFunctionRepository(
      dio: dio,
      config: FirebaseFunctionsConfig(isLocal: true),
    );

    final firestore = FirebaseFirestoreRepository(
      firestore: FirebaseFirestore.instance,
    );

    return RepositoriesInheritedModel(
      repositories: [
        functions,
        firestore,
      ],
      child: UserInheritedNotifier(
        notifier: UserChangeNotifier(functions: functions),
        child: FriendsInheritedNotifier(
          notifier: FriendsChangeNotifier(functions: functions),
          child: ChatsInheritedNotifier(
            notifier: ChatsChangeNotifier(
              functions: functions,
              firestore: firestore,
            ),
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
