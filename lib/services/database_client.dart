import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/item.dart';

/// Client database
abstract class DatabaseClient {

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
    creation_date TEXT NULL,
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
    creation_date TEXT NULL,
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

  @protected
  ///Convert Datetime to ISO 8601
  String convertDatetimeToString(DateTime date) {
    return date.toUtc().toIso8601String();
  }
  @protected
  ///Add item
  Future<int> addItem({required Item item}) async {
    Database db = await database;
    final int id = await db.insert(
        'item',
        {
          'name': item.name,
          'price': item.price,
          'shop' : item.shop,
          'creation_date' : (item.creationDate == null)? null : convertDatetimeToString(item.creationDate!),
          'archiving_date' : (item.archivingDate == null)? null : convertDatetimeToString(item.archivingDate!),
          'status' : item.status
        }
    );
    return id;
  }
  Future<List<Item>> getItemsByListId({required int listId}) async{
    Database db = await database;
    List<Map<String, Object?>> items = await db.rawQuery('''
      SELECT item.* 
      FROM item 
      LEFT JOIN list_item ON item.id = list_item.item_id 
      WHERE list_id=?               
    ''',
        [listId]
    );
    List<Item> itemList = [];
    for (var i = 0;i < items.length; i++){
      itemList.add(
          items.map((map) => Item.fromMap(map,listId)).toList()[i]
      );
    }
    return itemList;
  }

  @protected
  ///Associates items with lists because a list can have items and an item can be in several lists
  Future<bool> associateListWithItem(int listId, int itemId) async {
    Database db = await database;
    await db.insert(
      'list_item',
      {'list_id': listId, 'item_id': itemId},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return true;
  }
}