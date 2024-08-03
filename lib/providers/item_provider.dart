import 'package:flutter/material.dart';

import '../models/item.dart';
import '../services/database_client.dart';

class ItemProvider with ChangeNotifier {

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController shopController = TextEditingController();

  ///Ad item to list
  addItemToList({required int listId}){
    DatabaseClient().addItemToList(item: Item(
        name: nameController.text,
        price: double.tryParse(priceController.text),
        shop: shopController.text,
        status: false,
        creationDate: DateTime.now(),
        itemListId: listId
    ));
    notifyListeners();
  }
  ///Reset all fields of Item
  resetItem(){
    nameController.text = "";
    priceController.text = "";
    shopController.text = "";
  }
}