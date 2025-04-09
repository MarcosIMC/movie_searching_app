import 'package:flutter_test/flutter_test.dart';
import 'package:movie_searching/models/user.dart';
import 'package:movie_searching/services/sql_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  group('Database CRUD should', () {
    late SqlHelper dbHelper;
    late Database db;

    setUp(() async {
      var databasePath = await getDatabasesPath();
      String path = join(databasePath, 'test.db');
      db = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE users (id TEXT PRIMARY KEY NOT NULL, name TEXT, surname TEXT, email TEXT, password TEXT)"
        );
        await db.execute(
            "CREATE TABLE favourites (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, user TEXT FOREING KEY NOT NULL, title TEXT NOT NULL"
        );
      });
      dbHelper = SqlHelper.instance;
    });

    tearDown(() async {
      await db.close();
    });

    test('Insert user', () async {
      final user = User('Marcos', 'Medina', 'mm@mm.com', '12345', '123445', []);
      final insertId = await dbHelper.insertUser(user);
      expect(insertId, isNotNull);
    });
  });
}