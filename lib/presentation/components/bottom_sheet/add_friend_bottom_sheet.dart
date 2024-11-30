import 'package:fluttalk/presentation/inherited/friends_inherited_notifier.dart';
import 'package:fluttalk/presentation/components/bottom_sheet/custom_sliver_header_delegate.dart';
import 'package:fluttalk/presentation/components/common/custom_button.dart';
import 'package:fluttalk/presentation/components/common/search_text_field.dart';
import 'package:fluttalk/presentation/theme/my_colors.dart';
import 'package:fluttalk/presentation/theme/my_text_styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddFriendBottomSheet extends StatefulWidget {
  const AddFriendBottomSheet({super.key});

  @override
  State<AddFriendBottomSheet> createState() => _AddFriendBottomSheetState();
}

class _AddFriendBottomSheetState extends State<AddFriendBottomSheet> {
  final _textEditingController = TextEditingController();

  _onAdd(BuildContext context) async {
    final friendsChangeNotifier = FriendsInheritedNotifier.read(context);
    try {
      await friendsChangeNotifier.add(_textEditingController.text);
    } on DioException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(
              '친구를 추가할 수 없습니다.(${e.response?.statusMessage} ${e.response?.statusCode ?? 500})',
            ),
          ),
        );
      }
    } finally {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            delegate: CustomSliverHeaderDelegate(
              widget: Text(
                "친구 추가하기",
                style: MyTextStyles.subheading2.copyWith(
                  color: MyColors.neutralActive,
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Center(
                      child: SearchTextField(
                        placeholder: '이메일 주소를 입력해주세요.',
                        controller: _textEditingController,
                      ),
                    ),
                  ),
                  CustomButton(
                    onTap: () => _onAdd(context),
                    isPrimary: true,
                    title: '추가',
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    onTap: () => Navigator.of(context).pop(),
                    isPrimary: false,
                    title: '닫기',
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
