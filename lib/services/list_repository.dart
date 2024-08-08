import 'package:shopping_list/services/database_client.dart';
import 'package:sqflite/sqflite.dart';

import '../models/item.dart';
import '../models/item_list.dart';

///List repository
class ListRepository extends DatabaseClient {

  /// Add a list with items if any
  Future<int> addList({required ItemList itemList}) async {
    Database db = await database;
    final int id = await db.insert(
      'list',
      {
        'title': itemList.title,
        'description': itemList.description,
        'creation_date' : (itemList.creationDate == null)? null : convertDatetimeToString(itemList.creationDate!),
        'archiving_date' : (itemList.archivingDate == null)? null : convertDatetimeToString(itemList.archivingDate!),
        'total_price' : itemList.totalPrice
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    if(itemList.items != null){
      List<int> itemListId = [];
      for (var item in itemList.items!){
        itemListId.add(addItem(item: item) as int);
      }
      for (var itemId in itemListId ){
        associateListWithItem(id, itemId);
      }
    }
    return id;
  }

  ///Remove list
  Future<void> removeListById({required int listId}) async {
    Database db = await database;
    await db.delete(
        'list',
        where: 'id = ?',
        whereArgs: [listId]
    );
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

    List<Item> itemList = await getItemsByListId(listId: listId);
    ItemList list = mapList.map((map) => ItemList.fromMap(map)).toList().first;

    for(var i=0; i<itemList.length;i++){
      list.addItem(item: itemList[i]);
    }

    return list;
  }
  ///Get lists
  Future<List<ItemList>> getAllLists() async {
    Database db = await database;

    final result = await db.query('list');

    return result.map((map) => ItemList.fromMap(map)).toList();
  }
}