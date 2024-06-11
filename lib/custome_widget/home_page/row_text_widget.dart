import 'package:flutter/material.dart';
import 'package:you_read_app_flutter/custome_widget/text_widget/text_widget.dart';

class RowTextWidget extends StatefulWidget {
  const RowTextWidget({
    super.key,
    this.title,
    this.sized,
    this.textColor,
  });
  final String? title;
  final double? sized;
  final Color? textColor;

  @override
  State<RowTextWidget> createState() => _RowTextWidgetState();
}

class _RowTextWidgetState extends State<RowTextWidget> {
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
        title: widget.title,
        fontSize: 18,
        textColor: widget.textColor,
      ),
    );
  }
}
