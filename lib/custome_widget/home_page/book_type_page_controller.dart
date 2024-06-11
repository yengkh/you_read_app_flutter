
import 'package:flutter/material.dart';
import 'package:you_read_app_flutter/screens/home_page_body/book_type_items.dart';

class BookTypePageController extends StatelessWidget {
  const BookTypePageController({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: ThemDataClass.bodyColor,
      appBar: AppBar(
        //backgroundColor: ThemDataClass.appBarBackgrowndColor,
        title: Text(title),
      ),
      body: BookTypeItemAllItems(
        type: title,
      ),
    );
  }
}
