import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttalk/presentation/components/common/custom_button.dart';
import 'package:flutter/material.dart';

class MoreLogoutItem extends StatelessWidget {
  const MoreLogoutItem({super.key});

  _logout(BuildContext context) {
    final scaffoleMessenger = ScaffoldMessenger.of(context);
    FirebaseAuth.instance.signOut().then((_) {
      scaffoleMessenger.showSnackBar(
        const SnackBar(content: Text('로그아웃되었습니다.')),
      );
    }).catchError((error) {
      scaffoleMessenger.showSnackBar(
        SnackBar(content: Text('로그아웃 실패: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomButton(
        onTap: () => _logout(context),
        isPrimary: false,
        title: "로그아웃",
      ),
    );
  }
}
