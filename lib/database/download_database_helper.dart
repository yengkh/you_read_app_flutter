import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";
import 'package:you_read_app_flutter/models/download_model.dart';

class DownloadHelper {
  static const int _version = 1;
  static const String _dbName = "Download.db";

  static Future<void> _createTable(Database db) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS Download_File(id INTEGER PRIMARY KEY, name TEXT NOT NULL, type TEXT NOT NULL, author TEXT NOT NULL, file TEXT NOT NULL, image BLOB NOT NULL);");
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

  static Future<int> addToDownload(DownloadModel downloadModel) async {
    try {
      final db = await _getDB();
      await _createTable(db);

      return await db.insert(
        "Download_File",
        downloadModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error to adding to Download $e");
      }

      return -1;
    }
  }

  static Future<int> updateFromDownload(DownloadModel downloadModel) async {
    final db = await _getDB();
    await _createTable(db);

    return await db.update(
      "Download_File",
      downloadModel.toJson(),
      where: "id = ?",
      whereArgs: [downloadModel.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> deleteFromDownloadById(int id) async {
    final db = await _getDB();
    await _createTable(db);

    return await db.delete(
      "Download_File",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<int> deleteFromDownload(DownloadModel downloadModel) async {
    final db = await _getDB();
    await _createTable(db);

    return await db.delete(
      "Download_File",
      where: "id = ?",
      whereArgs: [downloadModel.id],
    );
  }

  static Future<List<DownloadModel>?> getAll() async {
    final db = await _getDB();
    await _createTable(db);
    List<Map<String, dynamic>> maps = await db.query("Download_File");

    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
      maps.length,
      (index) => DownloadModel.fromJson(maps[index]),
    );
  }

  
  static Stream<List<DownloadModel>> getAllStream() async* {
    final db = await _getDB();
    await _createTable(db); // Ensure table exists
    const batchSize = 100; // Adjust batch size as needed

    for (var offset = 0;; offset += batchSize) {
      final List<Map<String, dynamic>> maps = await db.query(
        'Download_File',
        limit: batchSize,
        offset: offset,
      );
      if (maps.isEmpty) break;

      yield maps.map((map) => DownloadModel.fromJson(map)).toList();
    }
  }
}
