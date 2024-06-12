import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    this.title,
    this.fontSize,
    this.textColor,
    this.iconData,
    this.iconSize,
  });
  final String? title;
  final double? fontSize;
  final Color? textColor;
  final IconData? iconData;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          size: iconSize,
        ),
        const SizedBox(
          width: 10.0,
        ),
        Text(
          title!,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
