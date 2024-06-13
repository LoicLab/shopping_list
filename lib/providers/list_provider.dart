import 'package:flutter/material.dart';
import 'package:shopping_list/models/item_list.dart';

import '../services/database_client.dart';

class ListProvider with ChangeNotifier {

  ///All list
  late List<ItemList> lists = [];

  ///Construct for get the all lists
  ListProvider(){
    getAll();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController totalPriceController = TextEditingController();

  /*remove(ItemList itemList){
    //_itemList.remove(itemList);
    notifyListeners();
  }*/
  ///Add lit in database and refresh all lists
  add(){
    DatabaseClient().addList(
        itemList: ItemList(
            title: titleController.text,
            description: descriptionController.text,
            creationDate: DateTime.now(),
            totalPrice: double.tryParse(totalPriceController.text) ?? 00.00
        )
    );
    getAll();
    notifyListeners();
  }
  ///Get all lists
  Future<void> getAll() async {
    lists = await DatabaseClient().getAllLists();
    notifyListeners();
  }

}