import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:you_read_app_flutter/translations/locale_key.g.dart';

class ReadPageItemInfo extends StatelessWidget {
  const ReadPageItemInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
            const Icon(
              Icons.info,
              color: Colors.white,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text(
              easy_localization.tr(LocaleKeys.see_book_detail),
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
