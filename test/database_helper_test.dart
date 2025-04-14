import 'package:flutter_test/flutter_test.dart';
import 'package:movie_searching/models/user.dart';
import 'package:movie_searching/services/sql_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('Database CRUD should', () {
    late Database db;
    
    setUpAll(() {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    setUp(() async {
      db = await databaseFactory.openDatabase(inMemoryDatabasePath, options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await SqlHelper.instance.onCreate(db, version);
        }
      ));

      SqlHelper.injectTestDatabase(db);
    });

    tearDown(() async {
      await db.close();
    });

    test('Insert user', () async {
      final user = User('Marcos', 'Medina', id: 'asd', email: 'm@m.es', password: '12345');
      final insertId = await SqlHelper.instance.insertUser(user);
      expect(insertId, isNotNull);
    });

    test('Do login', () async {
      final user = User('Marcos', 'Medina', id: 'asd', email: 'm@m.es', password: '12345');
      final insertId = await SqlHelper.instance.insertUser(user);
      expect(user, isNotNull);
    });
  });
}