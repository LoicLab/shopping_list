import 'package:flutter/material.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/models/item_list.dart';

import '../services/database_client.dart';

///Items provider
class ItemsProvider with ChangeNotifier {
  late List<Item> items = [];
  late Item item;
  late int listId;

  ///Update status of item
  updateItemStatus({required int index}){
    //Change status
    Item item = items[index];
    item.status = !item.status;
    //Update database
    DatabaseClient().updateItem(item: items[index]);
    notifyListeners();
  }

  Future<void> getItemsByListId({required int listId}) async {
    items = await DatabaseClient().getItemsByListId(listId: listId);
    notifyListeners();
  }

}