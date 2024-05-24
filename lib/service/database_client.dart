import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseClient {

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return await createDatabase();
  }

  Future<Database> createDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'database.db');
    return await openDatabase(
        path,
        version: 1,
        onCreate: onCreate
    );
  }

  onCreate(Database database, int version) async {
    //Table list
    await database.execute('''
    CREATE TABLE lists (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT NULL,
    creation_date TEXT NULL,
    archiving_date TEXT NULL,
    total_price REAL DEFAULT 0
    )
    ''');

    //Table item
    await database.execute('''
    CREATE TABLE items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    price REAL NULL,
    shop TEXT NULL,
    image TEXT,
    creation_date TEXT NULL,
    archiving_date TEXT NULL,
    status INTEGER NOT NULL DEFAULT 0
    )
    ''');

    //Table jonction
    await database.execute('''
    CREATE TABLE list_items (
    list_id INTEGER NOT NULL,
    item_id INTEGER NOT NULL,
    PRIMARY KEY (list_id, item_id),
    FOREIGN KEY (list_id) REFERENCES lists (id),
    FOREIGN KEY (item_id) REFERENCES items (id)
    )
    ''');
  }

  Future<bool> addList(String name, String description) async {
    Database db = await database;
    await db.insert(
      'lists',
      {'name': name, 'description': description},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return true;
  }

  Future<bool> associateListWithItem(int listId, int articleId) async {
    Database db = await database;
    await db.insert(
      'list_articles',
      {'list_id': listId, 'article_id': articleId},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return true;
  }
}