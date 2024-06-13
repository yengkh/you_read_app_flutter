import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.title,
    required this.iconsLeading,
  });
  final String title;
  final IconData iconsLeading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      tileColor: Colors.blue,
      title: Text(title),
      leading: Icon(
        iconsLeading,
      ),
    );
  }
}