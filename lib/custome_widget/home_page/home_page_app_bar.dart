import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:you_read_app_flutter/translations/locale_key.g.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          easy_localization.tr(LocaleKeys.hello_text),
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        const Text(
          "Yeng",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }
}
