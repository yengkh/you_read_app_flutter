import 'package:flutter/material.dart';

class ReadPageItem extends StatelessWidget {
  const ReadPageItem({
    super.key,
    required this.iconData,
    required this.title,
    required this.onTapEvent,
    this.snackBarTitle,
  });
  final IconData iconData;
  final String title;
  final VoidCallback onTapEvent;
  final String? snackBarTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapEvent();
        // Show SnackBar after the current frame
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(snackBarTitle!),
              duration: const Duration(seconds: 2),
            ),
          );
        });
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              color: Colors.white,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
