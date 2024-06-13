import 'package:flutter/material.dart';

class NoInternetButton extends StatelessWidget {
  const NoInternetButton({
    super.key,
    required this.onTapEvent,
    required this.title,
  });

  final Function() onTapEvent;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size(150, 30),
        backgroundColor: Colors.blue,
      ),
      onPressed: onTapEvent,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
