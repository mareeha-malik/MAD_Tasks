import 'package:sqflite/sqflite.dart';
import '../models/location_model.dart';
import 'database_helper.dart';

class LocationService {
  final DatabaseHelper dbHelper;

  LocationService(this.dbHelper);

  Future<int> addLocation(Location location) async {
    final db = await dbHelper.database;
    return await db.insert('locations', location.toMap());
  }

  Future<List<Location>> getLocations(int userId) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'locations',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    return List.generate(maps.length, (i) {
      return Location(
        id: maps[i]['id'],
        userId: maps[i]['userId'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        imagePath: maps[i]['imagePath'],
      );
    });
  }

  Future<int> updateLocation(Location location) async {
    final db = await dbHelper.database;
    return await db.update(
      'locations',
      location.toMap(),
      where: 'id = ?',
      whereArgs: [location.id],
    );
  }

  Future<int> deleteLocation(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'locations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}