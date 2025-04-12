import 'package:sqflite/sqflite.dart';
import '../models/user_model.dart';
import 'database_helper.dart';

class AuthService {
  final DatabaseHelper dbHelper;

  AuthService(this.dbHelper);

  Future<int> registerUser(User user) async {
    try {
      final db = await dbHelper.database;
      return await db.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort,
      );
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  Future<User?> loginUser(String name, String password) async {
    try {
      final db = await dbHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        'users',
        where: 'name = ? AND password = ?',
        whereArgs: [name, password],
        limit: 1,
      );
      return maps.isNotEmpty ? User.fromMap(maps[0]) : null;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
  Future<User?> getCurrentUser() async {
    try {
      final db = await dbHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        'users',
        limit: 1,
      );
      return maps.isNotEmpty ? User.fromMap(maps[0]) : null;
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  Future<void> logout() async {
    return;
  }

  Future<bool> userExists(String name) async {
    try {
      final db = await dbHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        'users',
        where: 'name = ?',
        whereArgs: [name],
        limit: 1,
      );
      return maps.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check user existence: $e');
    }
  }
}