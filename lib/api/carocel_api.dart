import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:you_read_app_flutter/models/carocel_model.dart';

class CarocelAPI {
  static const String baseURL = "http://192.168.43.83:8080/books/get-carocel";

  static Future<List<CaroModel>> getImage() async {
    final response = await http.get(Uri.parse(baseURL));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => CaroModel.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}