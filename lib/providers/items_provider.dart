import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/services/item_repository.dart';
import 'package:shopping_list/services/list_repository.dart';

///Items provider
class ItemsProvider with ChangeNotifier {
  ///Items list
  late List<Item> items = [];
  ///Items list filtered for search
  late List<Item> _filteredItems = [];
  late Item item;
  TextEditingController searchValue = TextEditingController();

  List<Item> get filteredItems => _filteredItems.isEmpty ? items : _filteredItems;

  ///Update status of item
  updateItemStatus({required int index}){
    //Change status
    Item item = _filteredItems[index];
    item.status = !item.status;
    //Update database
    ItemRepository().updateItem(item: _filteredItems[index]);
    notifyListeners();
  }

  ///Remove item
  removeItem({required int index}){
    ItemRepository().removeItemById(itemId: _filteredItems[index].id!);
    //Current list remove item
    _filteredItems.removeAt(index);
    notifyListeners();
  }

  ///Get items by list id
  Future<void> getItemsByListId({required int listId}) async {
    List<Item> newItems = await ListRepository().getItemsByListId(listId: listId);
    //For add new item and refresh the list
    if(newItems.length > items.length){
      _filteredItems = newItems;
    }
    items = newItems;
    //If change of list reset search
    if(
      _filteredItems.isNotEmpty && _filteredItems.first.itemListId != listId ||
      _filteredItems.isEmpty
    ){
      resetSearch();
    }
    notifyListeners();
  }

  ///Search items in list by query
  void searchItems({required String query}) {
    if (query.isEmpty) {
      _filteredItems = items;
    } else {
      _filteredItems = items
          .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void resetSearch() {
    searchValue.clear();
    _filteredItems = items;
    notifyListeners();
  }
}