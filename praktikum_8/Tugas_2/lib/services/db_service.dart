import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    log('SQLite Location: $path');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        purchase_price INTEGER,
        selling_price INTEGER,
        stock INTEGER
      )
    ''');
  }

  // Ensuring the database is closed only when necessary
  static Future<void> close() async {
    if (_database != null && _database!.isOpen) {
      final db = await getDatabase();
      await db.close();
      _database = null;
    }
  }
}
