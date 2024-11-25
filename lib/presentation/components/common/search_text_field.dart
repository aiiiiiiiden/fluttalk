import 'package:fluttalk/gen/assets.gen.dart';
import 'package:fluttalk/presentation/components/common/common_text_field.dart';
import 'package:fluttalk/presentation/theme/my_colors.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final String placeholder;
  final Function(String text) onChangedText;
  final EdgeInsetsGeometry padding;
  const SearchTextField({
    required this.placeholder,
    required this.onChangedText,
    this.padding = const EdgeInsets.all(0),
    super.key,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onChangedText);
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_onChangedText);
    super.dispose();
  }

  _onChangedText() {
    widget.onChangedText(_textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: CommonTextField(
        textEditingController: _textEditingController,
        hintText: widget.placeholder,
        prefixIcon: Assets.icons.searchLight.image(
          scale: 2,
          color: MyColors.neutralDisabled,
        ),
      ),
    );
  }
}
