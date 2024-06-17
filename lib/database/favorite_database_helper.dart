import "package:path/path.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:you_read_app_flutter/models/favorite_model.dart';

class FavoriteDatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Favorite.db";

  static Future<void> _createTable(Database db) async {
    await db.execute(
      "CREATE TABLE IF NOT EXISTS Favorite(id INTEGER PRIMARY KEY, name TEXT NOT NULL, author TEXT NOT NULL, type TEXT NOT NULL, file TEXT NOT NULL, image TEXT NOT NULL);",
    );
  }

  static Future<Database> _getDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    final path = join(await getDatabasesPath(), _dbName);
    return openDatabase(
      path,
      onCreate: (db, version) async {
        await _createTable(db);
      },
      version: _version,
    );
  }

  static Future<int> addToFavorite(FavoriteModel sqlModel) async {
    try {
      final db = await _getDB();
      await _createTable(db); // Ensure table exists
      return await db.insert(
        "Favorite",
        sqlModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      // Handle the error, e.g., log it or show an error message
      if (kDebugMode) {
        print("Error adding to favorite: $e");
      }
      return -1; // Return an error code
    }
  }

  static Future<int> updateFavorite(FavoriteModel sqlModel) async {
    final db = await _getDB();
    await _createTable(db); // Ensure table exists
    return await db.update(
      "Favorite",
      sqlModel.toJson(),
      where: "id = ?",
      whereArgs: [sqlModel.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> deleteFavoriteById(int id) async {
    final db = await _getDB();
    await _createTable(db); // Ensure table exists
    return await db.delete(
      "Favorite",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<int> deleteFavorite(FavoriteModel sqlModel) async {
    final db = await _getDB();
    await _createTable(db); // Ensure table exists
    return await db.delete(
      "Favorite",
      where: "id = ?",
      whereArgs: [sqlModel.id],
    );
  }

  static Future<List<FavoriteModel>?> getAll() async {
    final db = await _getDB();
    await _createTable(db); // Ensure table exists
    //const batchSize = 100; // Adjust batch size as needed
    final List<Map<String, dynamic>> maps = await db.query("Favorite");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
      maps.length,
      (index) => FavoriteModel.fromJson(maps[index]),
    );
  }
}
