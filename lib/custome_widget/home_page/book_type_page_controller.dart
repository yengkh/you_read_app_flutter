import 'package:flutter/material.dart';
import 'package:you_read_app_flutter/screens/home_page_body/book_type_items.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:you_read_app_flutter/translations/locale_key.g.dart';

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
      appBarTitle = LocaleKeys.leadership.tr();
    } else if (widget.title == "Children") {
      appBarTitle = LocaleKeys.children.tr();
    } else if (widget.title == "Education") {
      appBarTitle = LocaleKeys.education.tr();
    } else if (widget.title == "Language") {
      appBarTitle = LocaleKeys.language.tr();
    } else if (widget.title == "Nature") {
      appBarTitle = LocaleKeys.nature.tr();
    } else if (widget.title == "Business") {
      appBarTitle = LocaleKeys.business.tr();
    } else if (widget.title == "Religion") {
      appBarTitle = LocaleKeys.religion.tr();
    } else if (widget.title == "Technology") {
      appBarTitle = LocaleKeys.technology.tr();
    } else if (widget.title == "Self-Development") {
      appBarTitle = LocaleKeys.self_development.tr();
    } else if (widget.title == "Not-Show") {
      appBarTitle = LocaleKeys.not_show.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
