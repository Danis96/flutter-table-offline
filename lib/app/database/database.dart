import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tableproject/app/utils/constants.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {
  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  DatabaseHelper._createInstance();

  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = p.join(directory.path, 'tableproject.db');
    final Database database = await openDatabase(
      path,
      version: _scripts.length,
      onCreate: (Database db, int version) async {
        print('DB created');
        for (int i = 1; i <= _scripts.length; i++) {
          for (int j = 0; j < _scripts[i]!.length; j++) {
            await db.execute(_scripts[i]![j]);
          }
        }
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        print('DB upgraded');
        for (int i = oldVersion + 1; i <= newVersion; i++) {
          for (int j = 0; j < _scripts[i]!.length; j++) {
            await db.execute(_scripts[i]![j]);
          }
        }
      },
      onOpen: (Database db) {
        print('DB opened');
      },
    );
    return database;
  }

  Future<void> deleteDb(Database db) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = p.join(directory.path, 'tableproject.db');
    db = null as Database;
    _database = null;
    await deleteDatabase(path);
  }
}

// Make sure versions are sequential starting with 1
// ignore: always_specify_types
const Map<int, List<String>> _scripts = {
  1: <String>[
    '''
      CREATE TABLE ${Constants.USER_COMMENTS_TABLE} (
        id INTEGER PRIMARY KEY,
        postId INTEGER,
        name TEXT,
        email TEXT,
        body TEXT
      )
    '''
  ]
};
