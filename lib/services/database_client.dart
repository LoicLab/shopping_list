import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/item.dart';
import '../models/item_list.dart';

/// Client database
class DatabaseClient {

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return await createDatabase();
  }

  /// Creation database
  Future<Database> createDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'database.db');
    return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate
    );
  }

  _onCreate(Database database, int version) async {
    //Table list
    await database.execute('''
    CREATE TABLE list (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT NULL,
    creation_date TEXT NOT NULL,
    archiving_date TEXT NULL,
    total_price REAL DEFAULT 0
    )
    ''');

    //Table item
    await database.execute('''
    CREATE TABLE item (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    price REAL NULL,
    shop TEXT NULL,
    creation_date TEXT NOT NULL,
    archiving_date TEXT NULL,
    status INTEGER NOT NULL DEFAULT 0
    )
    ''');

    //Table jonction
    await database.execute('''
    CREATE TABLE list_item (
    list_id INTEGER NOT NULL,
    item_id INTEGER NOT NULL,
    PRIMARY KEY (list_id, item_id),
    FOREIGN KEY (list_id) REFERENCES list (id),
    FOREIGN KEY (item_id) REFERENCES item (id)
    )
    ''');
  }

  /// Add a list with items if any
  Future<int> addList({required ItemList itemList}) async {
    Database db = await database;
    final int id = await db.insert(
      'list',
      {
        'title': itemList.title,
        'description': itemList.description,
        'creation_date' : _convertDatetimeToString(itemList.creationDate),
        'archiving_date' : (itemList.archivingDate == null)? null : _convertDatetimeToString(itemList.archivingDate!),
        'total_price' : itemList.totalPrice
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    if(itemList.items != null){
      List<int> itemListId = [];
      for (var item in itemList.items!){
        itemListId.add(_addItem(item: item) as int);
      }
      for (var itemId in itemListId ){
        _associateListWithItem(id, itemId);
      }
    }
    return id;
  }
  ///Add item
  Future<int> _addItem({required Item item}) async {
    Database db = await database;
    final int id = await db.insert(
        'item',
        {
          'name': item.name,
          'price': item.price,
          'shop' : item.shop,
          'creation_date' : _convertDatetimeToString(item.creationDate),
          'archiving_date' : (item.archivingDate == null)? null : _convertDatetimeToString(item.archivingDate!),
          'status' : item.status
        }
    );
    return id;
  }
  ///Update fields list
  Future<void> updateListById({required ItemList itemList})  async {
    Database db = await database;
    final int numberChange = await db.update(
        'list',
        {
          'title': itemList.title,
          'description': itemList.description,
          'total_price' : itemList.totalPrice
        },
        where: 'id = ?',
        whereArgs: [itemList.id]
    );
  }
  ///Get list by id
  Future<ItemList> getListById({required int listId}) async {
    Database db = await database;
    List<Map<String, dynamic>> mapList = await db.query(
        'list',
        where: 'id = ?',
        whereArgs: [listId]
    );
    return mapList.map((map) => ItemList.fromMap(map)).toList().first;
  }
  ///Get lists
  Future<List<ItemList>> getAllLists() async {
    Database db = await database;

    final result = await db.rawQuery('''
      SELECT list.*
      FROM list
      LEFT JOIN list_item ON list.id = list_item.list_id
      LEFT JOIN item ON list_item.item_id = item.id
    ''');

    return result.map((map) => ItemList.fromMap(map)).toList();
  }
  ///Associates items with lists because a list can have items and an item can be in several lists
  Future<bool> _associateListWithItem(int listId, int itemId) async {
    Database db = await database;
    await db.insert(
      'list_item',
      {'list_id': listId, 'item_id': itemId},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return true;
  }
  ///Convert Datetime to ISO 8601
  String _convertDatetimeToString(DateTime date) {
    return date.toUtc().toIso8601String();
  }

}