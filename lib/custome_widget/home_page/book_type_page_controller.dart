import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_read_app_flutter/custome_widget/back_arrow.dart';
import 'package:you_read_app_flutter/screens/home_page_body/book_type_items.dart';
import 'package:you_read_app_flutter/translations/locale_key.g.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;

class BookTypePageController extends StatefulWidget {
  const BookTypePageController({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<BookTypePageController> createState() => _BookTypePageControllerState();
}

class _BookTypePageControllerState extends State<BookTypePageController> {
  late String appBarTitle;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ensure to set a default title
    appBarTitle = widget.title;
    if (widget.title == "Leadership") {
      easy_localization.tr(LocaleKeys.leadership);
    } else if (widget.title == "Children") {
      easy_localization.tr(LocaleKeys.children);
    } else if (widget.title == "Education") {
      easy_localization.tr(LocaleKeys.education);
    } else if (widget.title == "Language") {
      easy_localization.tr(LocaleKeys.language);
    } else if (widget.title == "Nature") {
      easy_localization.tr(LocaleKeys.nature);
    } else if (widget.title == "Business") {
      easy_localization.tr(LocaleKeys.business);
    } else if (widget.title == "Religion") {
      easy_localization.tr(LocaleKeys.religion);
    } else if (widget.title == "Technology") {
      easy_localization.tr(LocaleKeys.technology);
    } else if (widget.title == "Self-Development") {
      easy_localization.tr(LocaleKeys.self_development);
    } else if (widget.title == "Not-Show") {
      easy_localization.tr(LocaleKeys.not_show);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const BackArrow(),
        ),
        backgroundColor: Colors.blue[400],
        title: Text(
          appBarTitle,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: BookTypeItemAllItems(
        type: widget.title,
      ),
    );
  }
}
