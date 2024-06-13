import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:you_read_app_flutter/screens/read_page/read_page_from_book_category.dart';
import 'package:you_read_app_flutter/translations/locale_key.g.dart';

class BookTypeItemAllItems extends StatefulWidget {
  const BookTypeItemAllItems({super.key, required this.type});
  final String type;

  @override
  State<BookTypeItemAllItems> createState() => _BookTypeItemAllItemsState();
}

class BooksModel {
  final String id;
  final String name;
  final String author;
  final String type;
  final String desc;
  final String file;
  final String image;
  final String downloaded;

  BooksModel({
    required this.id,
    required this.name,
    required this.author,
    required this.type,
    required this.desc,
    required this.file,
    required this.image,
    required this.downloaded,
  });

  factory BooksModel.fromJson(Map<String, dynamic> json) {
    return BooksModel(
        id: json["id"],
        name: json["name"],
        author: json["author"],
        type: json["type"],
        desc: json["desc"],
        file: json["file"],
        image: json["image"],
        downloaded: json["downloaded"]);
  }
}

class API {
  static String getBooksURL(String type) {
    return "http://192.168.43.83:8080/books/find-books-by-type/$type";
  }
}

class _BookTypeItemAllItemsState extends State<BookTypeItemAllItems> {
  late List<BooksModel> books = [];

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    final response = await http.get(Uri.parse(API.getBooksURL(widget.type)));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        books = data.map((item) => BooksModel.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load books');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get current theme mode
    final themeMode = AdaptiveTheme.of(context).mode;
    // // Determine active color based on theme mode
    final activeColor = themeMode == AdaptiveThemeMode.dark;
    return books.isNotEmpty
        ? ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: SizedBox(
                    height: 160.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: activeColor
                                        ? Colors.blue
                                        : Colors.grey.withOpacity(0.5),
                                    spreadRadius: activeColor ? 0 : 5,
                                    blurRadius: activeColor ? 0 : 3,
                                    offset: activeColor
                                        ? const Offset(0, 0)
                                        : const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "http://192.168.43.83:8080/images/${book.image}",
                                  height: 160.0,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Expanded(
                              child: Container(
                                height: 160.0,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  boxShadow: [
                                    BoxShadow(
                                      color: activeColor
                                          ? Colors.blue
                                          : Colors.grey.withOpacity(0.5),
                                      spreadRadius: activeColor ? 0 : 5,
                                      blurRadius: activeColor ? 0 : 3,
                                      offset: activeColor
                                          ? const Offset(0, 0)
                                          : const Offset(0, 3),
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          easy_localization.tr(LocaleKeys.name),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Expanded(
                                          child: Text(
                                            book.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          easy_localization
                                              .tr(LocaleKeys.author),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Expanded(
                                          child: Text(
                                            book.author,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton(
                                          style: const ButtonStyle(
                                            minimumSize: WidgetStatePropertyAll(
                                                Size(100, 20)),
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    Colors.white),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            easy_localization
                                                .tr(LocaleKeys.detail),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        TextButton(
                                          style: const ButtonStyle(
                                            minimumSize: WidgetStatePropertyAll(
                                                Size(100, 20)),
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    Colors.white),
                                          ),
                                          onPressed: () {
                                            Get.to(
                                              ReadPageFromBookCategory(
                                                name: book.name,
                                                file: book.file,
                                                downloaded: book.downloaded,
                                                author: book.author,
                                                desc: book.desc,
                                                id: book.id,
                                                image: book.image,
                                                type: book.type,
                                              ),
                                            );
                                          },
                                          child: Text(
                                            easy_localization
                                                .tr(LocaleKeys.read),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
