import 'package:sqflite/sqflite.dart';
import 'package:warung_ajib/models/models.dart';
import 'package:warung_ajib/services/services.dart';

class UserRepository {
  final tableName = 'users';

  Future<User?> getUserByUsername(String username) async {
    final db = await DBService.getDatabase();
    final result = await db.query(
      tableName,
      columns: [
        'id',
        'username',
        'password',
      ],
      where: 'username = ?',
      whereArgs: [username],
    );

    db.close();

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<void> addUser(User newUser) async {
    final db = await DBService.getDatabase();
    await db.insert(
      tableName,
      newUser.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    db.close();
  }
}
