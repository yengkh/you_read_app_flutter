import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:you_read_app_flutter/models/notification_model.dart';

class NotificationHelper {
  static const int _version = 1;
  static const String _dbName = "Notification.db";
  static const String _tableName = "notifications";

  static Future<void> _createTable(Database db) async {
    await db.execute(
      "CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, file TEXT, name TEXT, author TEXT, type TEXT)",
    );
  }

  static Future<Database> _getDB() async {
    final path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(
      path,
      version: _version,
      onCreate: (db, version) async {
        await _createTable(db);
      },
    );
  }

  static Future<int> addPayload(NotificationModel notificationModel) async {
    final db = await _getDB();
    return await db.insert(
      _tableName,
      notificationModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<NotificationModel>> getAllPayloads() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(
      maps.length,
      (index) => NotificationModel.fromJson(maps[index]),
    );
  }

  static Future<int> deletePayloadById(int id) async {
    final db = await _getDB();
    return await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
