import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:you_read_app_flutter/models/book_model.dart';

class BookItemAPI {
  static const String baseURL = "http://192.168.43.83:8080/books/get";
  static Future<List<BookModel>> getAllBooks() async {
    final response = await http.get(Uri.parse(baseURL));

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => BookModel.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}