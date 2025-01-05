import 'package:sqflite/sqflite.dart';
import 'package:warung_ajib/models/models.dart';
import 'package:warung_ajib/services/services.dart';

class UserRepository {
  final tableName = 'users';

  Future<User?> getUserByUsername(String username) async {
    try {
      final db = await DBService.getDatabase();
      final result = await db.query(
        tableName,
        columns: ['id', 'fullname', 'username', 'password'],
        where: 'username = ?',
        whereArgs: [username],
      );

      if (result.isNotEmpty) {
        return User.fromMap(result.first);
      }
      return null;
    } catch (e) {
      print('Error fetching user by username: $e');
      return null;
    }
  }

  Future<void> addUser(User newUser) async {
    try {
      final db = await DBService.getDatabase();
      await db.insert(
        tableName,
        newUser.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error adding new user: $e');
      rethrow;
    }
  }
}
