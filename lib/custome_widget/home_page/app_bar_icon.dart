import 'package:flutter/material.dart';
// ignore: must_be_immutable
class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    this.iconButtonOnPress,
    this.iconData,
    this.iconSized, this.iconColor,
  });
  final Function()? iconButtonOnPress;
  final IconData? iconData;
  final double? iconSized;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: iconButtonOnPress,
      icon: Icon(
        iconData,
        size: iconSized,
        color: iconColor,
      ),
    );
  }
}
