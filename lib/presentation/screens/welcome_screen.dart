import 'package:fluttalk/presentation/components/common/custom_button.dart';
import 'package:fluttalk/presentation/screens/auth_state_screen.dart';
import 'package:fluttalk/presentation/theme/my_text_styles.dart';
import 'package:fluttalk/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  _moveNext(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const AuthStateScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Assets.images.login.image(scale: 2),
                const SizedBox(height: 42),
                const Text(
                  "다양한 플러터 개발자들과\n이야기를 나눠보세요",
                  style: MyTextStyles.heading2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 127),
                const Text(
                  "이용 약관 및 정책",
                  style: MyTextStyles.bodyText2,
                ),
                const SizedBox(height: 8),
                CustomButton(
                  isPrimary: true,
                  title: "대화 시작하기",
                  onTap: () => _moveNext(context),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
