import 'package:flutter/material.dart';
import 'package:shopping_list/services/item_repository.dart';

import '../models/item.dart';

class ItemProvider with ChangeNotifier {

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController shopController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  ///Ad item to list
  addItemToList({required int listId}){
    _checkPrice();
    ItemRepository().addItemToList(item: Item(
        name: nameController.text,
        price: double.tryParse(priceController.text),
        shop: shopController.text,
        status: false,
        quantity: int.tryParse(quantityController.text),
        creationDate: DateTime.now(),
        itemListId: listId
    ));
    notifyListeners();
  }
  ///Update item to list
  updateItemToList({required Item item}){
    _checkPrice();
    item.name = nameController.text;
    item.price = double.tryParse(priceController.text);
    item.shop = shopController.text;
    item.quantity = int.tryParse(quantityController.text);
    ItemRepository().updateItem(item: item);
    notifyListeners();
  }
  ///Get item for init fields form
  Future<void> getItemById({required int itemId}) async {
    Item item = await ItemRepository().getItemById(itemId: itemId);
    resetItem();
    nameController.text = item.name;
    shopController.text = item.shop!;
    if(item.price != null ){
      priceController.text = item.price!.toString();
    }
    if(item.quantity != null ){
      quantityController.text = item.quantity!.toString();
    }
    notifyListeners();
  }
  ///Reset all fields of Item
  resetItem(){
    nameController.text = "";
    priceController.text = "";
    shopController.text = "";
    quantityController.text = "1";
  }
  ///Replace comma to dot for text price
  _checkPrice(){
    if(priceController.text.isNotEmpty){
      priceController.text = priceController.text.replaceAll(',', '.');
    }
  }
  ///Increment quantity
  incrementQuantity() {
    int currentQuantity = int.tryParse(quantityController.text) ?? 1;
    currentQuantity++;
    quantityController.text = currentQuantity.toString();
    notifyListeners();
  }
  /// Decrement quantity
  decrementQuantity() {
    int currentQuantity = int.tryParse(quantityController.text) ?? 1;
    if (currentQuantity > 1) {
      currentQuantity--;
    }
    quantityController.text = currentQuantity.toString();
    notifyListeners();
  }
}