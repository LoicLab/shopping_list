import 'package:flutter/material.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/models/item_list.dart';

import '../services/database_client.dart';

class ListProvider with ChangeNotifier {

  ///All list
  late List<ItemList> lists = [];
  late List<Item> items = [];
  late ItemList list;

  ///Construct for get the all lists
  ListProvider(){
    getAll();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController totalPriceController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();

  ///Resets TextEditingController properties
  void resetTextEditingController(){
    titleController.text = "";
    descriptionController.text = "";
    totalPriceController.text = "";
  }
  ///Add lit in database and refresh all lists
  add(){
    DatabaseClient().addList( itemList: ItemList(
        title: titleController.text,
        description: descriptionController.text,
        creationDate: DateTime.now(),
        totalPrice: double.tryParse(totalPriceController.text) ?? 00.00
    ));
    getAll();
    notifyListeners();
  }
  ///Update list fields
  update({required int listId, required int index }){
    ItemList list = ItemList(
        id: listId,
        title: titleController.text,
        description: descriptionController.text,
        totalPrice: double.tryParse(totalPriceController.text) ?? 00.00
    );
    DatabaseClient().updateListById(itemList: list);
    //Replaces the list with the updated list
    lists[index] = list;
    notifyListeners();
  }
  ///Remove list
  remove({required int listId, required int index}){
    DatabaseClient().removeListById(listId: listId);
    lists.removeAt(index);
    notifyListeners();
  }
  ///Remove item
  removeItem({required Item item}){
    DatabaseClient().removeItemById(itemId: item.id!);
    //Current list remove item
    list.removeItem(item: item);
    //All lists remove item if exist
    for(list in lists){
      list.removeItem(item: item);
    }
    notifyListeners();
  }
  ///Get list by id
  Future<void> getListById({required int listId}) async {
    list = await DatabaseClient().getListById(listId: listId);
    titleController.text = list.title;
    descriptionController.text = list.description;
    totalPriceController.text = list.totalPrice.toString();
    itemNameController.text = "";
    itemPriceController.text = "";
    _initList(itemList: list);
    notifyListeners();
  }
  ///Get all lists
  Future<void> getAll() async {
    lists = await DatabaseClient().getAllLists();
    notifyListeners();
  }
  ///Ad item to list
  addItemToList({required int index}){
    DatabaseClient().addItemToList(item: Item(
        name: itemNameController.text,
        price: double.tryParse(itemPriceController.text),
        status: false,
        creationDate: DateTime.now(),
        itemListId: lists[index].id!
    ));
    getListById(listId: list.id!);
    notifyListeners();
  }
  ///Update list and items properties
  _initList({required ItemList itemList}){
    list = itemList;
    (list.items == null)?items=[]:items = list.items!;
  }
}