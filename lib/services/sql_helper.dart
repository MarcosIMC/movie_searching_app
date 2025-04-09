import 'dart:io';

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
        '''CREATE TABLE users (id TEXT PRIMARY KEY NOT NULL, name TEXT, surname TEXT, email TEXT, password TEXT)'''
    );
    await db.execute(
        '''CREATE TABLE favourites (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, userId TEXT NOT NULL, title TEXT NOT NULL, FOREIGN KEY (userId) REFERENCES users(id))'''
    );
  }

  Future<int?> insertUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<User?> login(String email, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password]
    );

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }

    return null;
  }

  Future<void> deleteDB() async {
    // Obtén la ruta de la base de datos
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/movieApp.db'; // Asegúrate de que coincida con el nombre de tu base de datos

    // Elimina el archivo de la base de datos
    final file = File(path);
    if (await file.exists()) {
    await file.delete();
    print('Base de datos eliminada');
    } else {
    print('No se encontró la base de datos');
    }
  }
}