import 'package:fluttalk/gen/assets.gen.dart';
import 'package:fluttalk/data/chat.dart';
import 'package:fluttalk/presentation/inherited/chat_inherited_notifier.dart';
import 'package:fluttalk/presentation/components/common/common_text_field.dart';
import 'package:fluttalk/presentation/theme/my_colors.dart';
import 'package:flutter/material.dart';

class ChatRoomMessageTextField extends StatefulWidget {
  final Chat chat;
  const ChatRoomMessageTextField({
    super.key,
    required this.chat,
  });

  @override
  State<ChatRoomMessageTextField> createState() =>
      _ChatRoomMessageTextFieldState();
}

class _ChatRoomMessageTextFieldState extends State<ChatRoomMessageTextField> {
  final _textEditingController = TextEditingController();
  bool _canSend = false;
  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onChangedMessage);
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_onChangedMessage);
    super.dispose();
  }

  _onChangedMessage() {
    setState(() {
      _canSend = _textEditingController.text.isNotEmpty;
    });
  }

  _sendMessage(BuildContext context) async {
    final chatChangeNotifier = ChatInheritedNotifier.read(context);
    await chatChangeNotifier.sendMessage(
      widget.chat.id,
      _textEditingController.text,
    );
    setState(() {
      _textEditingController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: MyColors.neutralWhite,
        child: Column(
          children: [
            Container(
              height: 1,
              color: MyColors.neutralLine,
            ),
            SizedBox(
              height: 56,
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  InkWell(
                    child: Assets.icons.plusLight.image(
                      scale: 2,
                      color: MyColors.neutralDisabled,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CommonTextField(
                        hintText: "메시지를 입력해주세요.",
                        textEditingController: _textEditingController,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: _canSend ? () => _sendMessage(context) : null,
                    child: Assets.icons.sendAltFilledLight.image(
                      scale: 2,
                      color: MyColors.brandDefault.withOpacity(
                        _canSend ? 1.0 : 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
