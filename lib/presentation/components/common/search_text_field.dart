import 'package:fluttalk/gen/assets.gen.dart';
import 'package:fluttalk/presentation/components/common/common_text_field.dart';
import 'package:fluttalk/presentation/theme/my_colors.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final String placeholder;
  final TextEditingController controller;
  final EdgeInsetsGeometry padding;
  const SearchTextField({
    required this.controller,
    required this.placeholder,
    this.padding = const EdgeInsets.all(0),
    super.key,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: CommonTextField(
        textEditingController: widget.controller,
        hintText: widget.placeholder,
        prefixIcon: Assets.icons.searchLight.image(
          scale: 2,
          color: MyColors.neutralDisabled,
        ),
      ),
    );
  }
}
