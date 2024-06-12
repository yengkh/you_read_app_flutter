import 'package:flutter/material.dart';
import 'package:you_read_app_flutter/custome_widget/text_widget/text_widget.dart';

class RowTextWidget extends StatelessWidget {
  const RowTextWidget({
    super.key,
    this.title,
    this.textColor,
    this.iconData,
    this.iconSize,
  });
  final String? title;
  final IconData? iconData;
  final double? iconSize;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        left: 15.0,
        right: 25.0,
        bottom: 10.0,
      ),
      child: TextWidget(
        iconData: iconData,
        iconSize: iconSize,
        title: title,
        fontSize: 18,
        textColor: textColor,
      ),
    );
  }
}
