// Helper class to interact with SQLite database
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:you_read_app_flutter/models/phone_number_model.dart';
import "package:path/path.dart";

class PhoneNumberHelper {
  static const int _version = 1;
  static const String _dbName = "PhoneNumber.db";

  static Future<void> _createTB(Database db) async {
    await db.execute(
      "CREATE TABLE IF NOT EXISTS PhoneNumberTB (id INTEGER PRIMARY KEY, phone INTEGER NOT NULL);",
    );
  }

  static Future<Database> _getDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    final path = join(await getDatabasesPath(), _dbName);

    return openDatabase(
      path,
      onCreate: (db, version) async {
        await _createTB(db);
      },
      version: _version,
    );
  }

  static Future<int> addPhoneNumber(PhoneNumberModel phoneNumberModel) async {
    final db = await _getDB();
    await _createTB(db);
    return await db.insert(
      "PhoneNumberTB",
      phoneNumberModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> updatePhoneNumber(
      PhoneNumberModel phoneNumberModel) async {
    final db = await _getDB();
    await _createTB(db);
    return db.update(
      "PhoneNumberTB",
      phoneNumberModel.toJson(),
      where: "id = ?",
      whereArgs: [phoneNumberModel.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> deletePhone(PhoneNumberModel phoneNumberModel) async {
    final db = await _getDB();
    await _createTB(db);
    return db.delete(
      "PhoneNumberTB",
      where: "id = ?",
      whereArgs: [phoneNumberModel.id],
    );
  }

  static Future<int> deletePhoneById(int id) async {
    final db = await _getDB();
    await _createTB(db);
    return db.delete(
      "PhoneNumberTB",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<List<PhoneNumberModel>?> getPhoneNumber() async {
    final db = await _getDB();
    await _createTB(db);
    final List<Map<String, dynamic>> maps = await db.query("PhoneNumberTB");

    if (maps.isEmpty) {
      return null;
    }

    // Return the first phone number in the list
    return List.generate(
      maps.length,
      (index) => PhoneNumberModel.fromJson(maps[index]),
    );
  }
}
