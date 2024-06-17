import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_read_app_flutter/api/search_book_by_name.dart';
import 'package:you_read_app_flutter/custome_widget/back_arrow.dart';
import 'package:you_read_app_flutter/custome_widget/home_page/custome_widget.dart';
import 'package:you_read_app_flutter/models/book_model.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:you_read_app_flutter/translations/locale_key.g.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<BookModel>>? _futureBooks;
  final FocusNode _focusNode = FocusNode();

  void _onSearchChanged() {
    setState(() {
      _futureBooks = SearchBookByName.getBookByName(_searchController.text);
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    // Initial fetch with empty query
    _futureBooks = SearchBookByName.getBookByName('');
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
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
        title: TextFormField(
          autofocus: true,
          focusNode: _focusNode,
          cursorColor: Colors.white,
          controller: _searchController,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  // Request focus after clearing text
                  _focusNode.requestFocus();
                });
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.white,
              ),
            ),
            hintText: easy_localization.tr(LocaleKeys.tap_to_search),
            border: InputBorder.none,
            hintStyle: const TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[400],
      ),
      body: FutureBuilder<List<BookModel>>(
        future: _futureBooks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/book.png",
                    height: 100.0,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    easy_localization.tr(LocaleKeys.no_book_found),
                  ),
                ],
              ),
            );
          }
          final data = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.only(
              top: 20.0,
              bottom: 80.0,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final book = data[index];
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 8.0,
                  left: 8.0,
                  right: 8.0,
                ),
                child: CustomeWidgetItems(
                  author: book.author,
                  desc: book.desc,
                  downloaded: book.downloaded,
                  file: book.file,
                  id: book.id,
                  image: book.image,
                  name: book.name,
                  type: book.type,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
