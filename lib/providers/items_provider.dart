import 'package:flutter/material.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/services/item_repository.dart';
import 'package:shopping_list/services/list_repository.dart';

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
    ItemRepository().updateItem(item: items[index]);
    notifyListeners();
  }

  ///Remove item
  removeItem({required int index}){
    ItemRepository().removeItemById(itemId: items[index].id!);
    //Current list remove item
    items.removeAt(index);
    notifyListeners();
  }

  Future<void> getItemsByListId({required int listId}) async {
    items = await ListRepository().getItemsByListId(listId: listId);
    notifyListeners();
  }

}