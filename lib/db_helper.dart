import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const versionNumber = 1;
  static const createQueries = [
    '''
CREATE TABLE breath_hold_histories(
  uniqueKey CHAR(5) PRIMARY KEY,
  datetime DATETIME NOT NULL,
  firstContraction VARCHAR(5),
  duration VARCHAR(5) NOT NULL
);''',
    '''
CREATE TABLE training_table_entry(
  trainingTableKey CHAR(8) NOT NULL,
  rowIndex INT NOT NULL,
  holdTime VARCHAR(5) NOT NULL,
  breatheTime VARCHAR(5) NOT NULL,
  PRIMARY KEY(trainingTableKey, rowIndex)
);''',
    '''
CREATE TABLE training_table(
  uniqueKey CHAR(8) PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(100)
);''',
    '''
CREATE TABLE training_histories(
  uniqueKey CHAR(8) PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(100) NOT NULL,
  datetime DATETIME NOT NULL
);'''
  ];

  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'apnea.db'),
      onCreate: (db, version) async {
        for (int i = 0; i < createQueries.length; i++) {
          await db.execute(createQueries[i]);
        }
      },
      version: versionNumber,
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> delete(
      String table, String identifier, String key) async {
    final db = await DBHelper.database();
    db.delete(table, where: '$identifier = ?', whereArgs: [key]);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<List<Map>> getTableEntries(String tableKey) async {
    final db = await DBHelper.database();
    return db.rawQuery(
        'SELECT * FROM training_table_entry WHERE trainingTableKey = ? ORDER BY rowIndex ASC',
        [tableKey]);
  }
}
