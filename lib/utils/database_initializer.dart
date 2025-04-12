import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseInitializer {
  static Future<void> initialize() async {
    try {
      if (kIsWeb) {
        // Web initialization
        databaseFactory = databaseFactoryFfiWeb;
      } else {
        // Mobile/Desktop initialization
        sqfliteFfiInit();
        databaseFactory = databaseFactoryFfi;
      }

      // Test database connection
      final db = await databaseFactory.openDatabase('test_db.db');
      await db.execute('CREATE TABLE IF NOT EXISTS test (id INTEGER PRIMARY KEY)');
      await db.close();

      print('Database initialized successfully');
    } catch (e) {
      print('Database initialization failed: $e');
      rethrow;
    }
  }
}