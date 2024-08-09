import 'package:shopping_list/services/database_client.dart';
import 'package:sqflite/sqflite.dart';

import '../models/item.dart';

///Item repository
class ItemRepository extends DatabaseClient {

  ///Update item
  Future<void> updateItem({required Item item}) async {
    Database db = await database;
    final int numberChange = await db.update(
        'item',
        {
          'name': item.name,
          'price': item.price,
          'shop' : item.shop,
          'creation_date' : (item.creationDate == null)? null : convertDatetimeToString(item.creationDate!),
          'archiving_date' : (item.archivingDate == null)? null : convertDatetimeToString(item.archivingDate!),
          'status' : item.status
        },
        where: 'id = ?',
        whereArgs: [item.id]
    );
  }

  ///Add item in the list
  Future<bool> addItemToList({required Item item}) async {
    final int itemId = await addItem(item: item);
    return associateListWithItem(item.itemListId, itemId);
  }
  ///Remove item
  Future<void> removeItemById({required int itemId}) async{
    Database db = await database;
    await db.delete(
        'item',
        where: 'id = ?',
        whereArgs: [itemId]
    );
    await db.delete(
        'list_item',
        where: 'item_id = ?',
        whereArgs: [itemId]
    );
  }
}