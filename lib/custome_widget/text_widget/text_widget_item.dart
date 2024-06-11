import 'package:flutter/material.dart';

class TextItemsWidget extends StatefulWidget {
  const TextItemsWidget({
    super.key,
    this.title,
    this.maxLine,
    this.styles,
  });
  final String? title;
  final int? maxLine;
  final TextStyle? styles;

  @override
  State<TextItemsWidget> createState() => _TextItemsWidgetState();
}

class _TextItemsWidgetState extends State<TextItemsWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title!,
      maxLines: widget.maxLine,
      overflow: TextOverflow.ellipsis,
      style: widget.styles,
    );
  }
}
