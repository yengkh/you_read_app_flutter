import 'dart:convert';
import 'package:you_read_app_flutter/models/book_model.dart';
import 'package:http/http.dart' as http;

class SearchBookByName {
  static Future<List<BookModel>> getBookByName(String name) async {
    List<BookModel> result = [];
    // Preprocess the search query
    String processedName = name.replaceAll(' ', '').toLowerCase();
    String baseURL =
        "http://192.168.43.83:8080/books/get-book-by-name?name=${Uri.encodeComponent(processedName)}";
    final response = await http.get(Uri.parse(baseURL));

    if (response.statusCode == 200) {
      var list = json.decode(response.body) as List;
      result = list.map((model) => BookModel.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load books');
    }
    return result;
  }
}
