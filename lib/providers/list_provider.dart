import 'package:flutter/material.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/models/item_list.dart';
import 'package:shopping_list/services/list_repository.dart';

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

  ///Resets TextEditingController properties
  void resetList(){
    titleController.text = "";
    descriptionController.text = "";
    totalPriceController.text = "";
    items = [];
  }
  ///Add lit in database and refresh all lists
  add(){
    ListRepository().addList( itemList: ItemList(
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
    ListRepository().updateListById(itemList: list);
    //Replaces the list with the updated list
    lists[index] = list;
    notifyListeners();
  }
  ///Remove list
  remove({required int listId, required int index}){
    ListRepository().removeListById(listId: listId);
    lists.removeAt(index);
    notifyListeners();
  }
  ///Get list by id
  Future<void> getListById({required int listId}) async {
    list = await ListRepository().getListById(listId: listId);
    titleController.text = list.title;
    descriptionController.text = list.description;
    totalPriceController.text = list.totalPrice.toString();
    _initList(itemList: list);
    notifyListeners();
  }
  ///Get all lists
  Future<void> getAll() async {
    lists = await ListRepository().getAllLists();
    notifyListeners();
  }

  ///Update list and items properties
  _initList({required ItemList itemList}){
    list = itemList;
    (list.items == null)?items=[]:items = list.items!;
  }
}