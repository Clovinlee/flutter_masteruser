import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppDatabase {
  static String dbName = "c_masteruserdb";
  static Database? _db;

  static Database? getDb() {
    if (_db == null) {
      initDatabase();
    }
    return _db;
  }

  static void initDatabase() async {
    String databasesPath = await getDatabasesPath();

    // Make sure the directory exists
    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (_) {}

    onConfigure(Database db) async {
      // Add support for cascade delete
      await db.execute("PRAGMA foreign_keys = ON");
    }

    _db ??= await openDatabase(dotenv.env["APP_DB"]!,
        onConfigure: onConfigure, version: 1);
  }
}
