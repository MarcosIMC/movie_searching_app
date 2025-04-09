import 'package:movie_searching/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlHelper {
  static final SqlHelper instance = SqlHelper._init();

  SqlHelper._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('movieApp.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }
  
  Future _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE users (id TEXT PRIMARY KEY NOT NULL, name TEXT, surname TEXT, email TEXT, password TEXT)"
    );
    await db.execute(
        "CREATE TABLE favourites (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, user TEXT FOREING KEY NOT NULL, title TEXT NOT NULL"
    );
  }

  Future<int?> insertUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }
}