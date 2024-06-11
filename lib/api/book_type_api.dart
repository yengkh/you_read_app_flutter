import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:you_read_app_flutter/models/book_type_model.dart';

class BookTypeAPI {
  static const String baseURL = "http://192.168.43.83:8080/books/get-book-type";

  static Future<List<BookTypeModel>> getData() async {
    final respone = await http.get(Uri.parse(baseURL));

    if (respone.statusCode == 200) {
      Iterable list = json.decode(respone.body);

      return list.map((model) => BookTypeModel.fronJson(model)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}