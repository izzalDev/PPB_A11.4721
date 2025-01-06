import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:warung_ajib/models/models.dart';

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

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullname TEXT,
        username TEXT,
        password TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT,
        price INTEGER,
        image TEXT
      )
    ''');

    await db.insert(
      'products',
      Product(
        name: ',Ayam Betutu',
        description:
            'Olahan ayam khas Gilimanuk, Bali, makanan pedas ini pasti akan memanjakan lidahmu dengan bumbu kuning yang lezat.',
        price: 20000,
        image: 'ayam_betutu.jpg',
      ).toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await db.insert(
      'products',
      Product(
        name: 'Ayam Taliwang',
        description:
            'Ayam Taliwang adalah makanan khas Taliwang, Sumbawa Barat, Nusa Tenggara Barat.',
        price: 15000,
        image: 'ayam_taliwang.jpg',
      ).toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await db.insert(
      'products',
      Product(
        name: 'Pepes Ayam',
        description:
            'Olahan ayam khas Sunda ini sangat nikmat disajikan dengan sepiring nasi putih hangat.',
        price: 18000,
        image: 'pepes_ayam.jpg',
      ).toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await db.insert(
      'products',
      Product(
        name: 'Ayam Bumbu Kemangi',
        description:
            'Aroma kemangi yang khas akan menambah cita rasa masakan ini.',
        price: 25000,
        image: 'ayam_kemangi.jpg',
      ).toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await db.insert(
      'products',
      Product(
        name: 'Ayam Rica-Rica',
        description: 'Ayam yang dimasak rica-rica juga sangat nikmat.',
        price: 30000,
        image: 'ayam_rica_rica.jpg',
      ).toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await db.insert(
      'products',
      Product(
        name: 'Ayam Panggang',
        description: 'Ayam panggang bisa kamu temukan di banyak tempat makan.',
        price: 30000,
        image: 'ayam_panggang.jpg',
      ).toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
