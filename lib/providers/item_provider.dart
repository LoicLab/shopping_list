import 'package:flutter/material.dart';
import 'package:shopping_list/services/item_repository.dart';

import '../models/item.dart';

class ItemProvider with ChangeNotifier {

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController shopController = TextEditingController();

  ///Ad item to list
  addItemToList({required int listId}){
    ItemRepository().addItemToList(item: Item(
        name: nameController.text,
        price: double.tryParse(priceController.text),
        shop: shopController.text,
        status: false,
        creationDate: DateTime.now(),
        itemListId: listId
    ));
    notifyListeners();
  }

  updateItemToList({required Item item}){
    item.name = nameController.text;
    item.price = double.tryParse(priceController.text);
    item.shop = shopController.text;
    ItemRepository().updateItem(item: item);
    notifyListeners();
  }

  Future<void> getItemById({required int itemId}) async {
    Item item = await ItemRepository().getItemById(itemId: itemId);
    nameController.text = item.name;
    priceController.text = item.price!.toString();
    shopController.text = item.shop!;
  }

  ///Reset all fields of Item
  resetItem(){
    nameController.text = "";
    priceController.text = "";
    shopController.text = "";
  }
}