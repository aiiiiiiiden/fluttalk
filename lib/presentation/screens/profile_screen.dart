import 'package:fluttalk/business/inherited_notifier/user_inherited_notifier.dart';
import 'package:fluttalk/presentation/components/common/common_text_field.dart';
import 'package:fluttalk/presentation/components/common/custom_button.dart';
import 'package:fluttalk/presentation/theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttalk/gen/assets.gen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _textEditingController = TextEditingController();
  bool canSave = false;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onChangedName);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileModel = UserInheritedNotifier.read(context);
      _textEditingController.text = profileModel.user?.displayName ?? "";
      canSave = _textEditingController.text.isNotEmpty;
    });
  }

  @override
  dispose() {
    _textEditingController.removeListener(_onChangedName);
    super.dispose();
  }

  _onChangedName() {
    setState(() {
      canSave = _textEditingController.text.isNotEmpty;
    });
  }

  _save(BuildContext context) async {
    final profileModel = UserInheritedNotifier.read(context);
    await profileModel.update(_textEditingController.text);
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("내 정보"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 45),
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  color: MyColors.neutralOffWhite,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Assets.icons.user.image(scale: 1),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 31),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CommonTextField(
                hintText: "이름을 입력해주세요.",
                textEditingController: _textEditingController,
              ),
            ),
          ),
          SliverFillRemaining(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32, left: 24, right: 24),
                child: CustomButton(
                  onTap: canSave ? () => _save(context) : null,
                  isPrimary: canSave,
                  title: "저장 하기",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
