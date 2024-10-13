import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const String favoriteDB = 'favorite_db';
const String favoriteImageTable = 'favoriteImageTable';

class DatabaseHelper {
  DatabaseHelper._databaseHelper();

  static final DatabaseHelper instance = DatabaseHelper._databaseHelper();
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, '$favoriteDB.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $favoriteImageTable(
      imageId TEXT PRIMARY KEY,
      imageUrl TEXT,
      displaySiteName TEXT,
      height INTEGER,
      width INTEGER
    )
    ''');
  }
}
