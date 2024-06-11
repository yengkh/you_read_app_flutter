import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  const TextWidget({
    super.key,
    this.title,
    this.fontSize,
    this.textColor,
  });
  final String? title;
  final double? fontSize;
  final Color? textColor;

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title!,
      style: TextStyle(
        fontSize: widget.fontSize,
        color: widget.textColor,
      ),
    );
  }
}
