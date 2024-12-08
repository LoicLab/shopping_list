import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/services/item_repository.dart';
import 'package:shopping_list/services/list_repository.dart';

///Items provider
class ItemsProvider with ChangeNotifier {
  ///Items list
  late List<Item> _items = [];
  ///Items list filtered for search
  late List<Item> _filteredItems = [];
  late Item item;
  TextEditingController searchValue = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController shopController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  List<Item> get filteredItems => _filteredItems.isEmpty ? items : _filteredItems;

  List<Item> get items {
    _sortItemsByStatus(_items);
    return _items;
  }

  ///Update status of item
  updateItemStatus({required int index}){
    //Change status
    Item item = _filteredItems[index];
    item.status = !item.status;
    //Update database
    ItemRepository().updateItem(item: _filteredItems[index]);
    _sortItemsByStatus(_filteredItems);
    notifyListeners();
  }

  ///Remove item
  Future<void> removeItem({required int index}) async {
    await ItemRepository().removeItemById(itemId: _filteredItems[index].id!);
    //If search mode
    if(searchValue.text.isNotEmpty){
      _items = await ListRepository().getItemsByListId(listId: _filteredItems[index].itemListId);
      _filteredItems = items;
    } else {
      _filteredItems.removeAt(index);
    }
    notifyListeners();
  }

  ///Get items by list id
  Future<void> getItemsByListId({required int listId}) async {
    List<Item> newItems = await ListRepository().getItemsByListId(listId: listId);
    _sortItemsByStatus(newItems);
    //For add new item or items list is empty, refresh the list
    if(newItems.length > _items.length || newItems.isEmpty){
      _filteredItems = newItems;
    }
    _items = newItems;
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
      _filteredItems = _items;
    } else {
      _filteredItems = _items
          .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  ///Reset search item list with item list
  ///Clear search value
  void resetSearch() {
    searchValue.clear();
    _filteredItems = items;
    notifyListeners();
  }
  ///Sort item list by status
  void _sortItemsByStatus(List<Item> itemList){
    itemList.sort((a, b) => a.status ? 1 : -1);
  }

  ///Empty the list of items
  emptyList({required int listId}){
    ItemRepository().removeAllItemsByListId(listId: listId);
    //Clear the list
    _filteredItems.clear();
    notifyListeners();
  }

  ///Ad item to list
  Future<void> addItemToList({required int listId}) async {
    _checkPrice();
    await ItemRepository().addItemToList(item: Item(
        name: nameController.text,
        price: double.tryParse(priceController.text),
        shop: shopController.text,
        status: false,
        quantity: int.tryParse(quantityController.text),
        creationDate: DateTime.now(),
        itemListId: listId
    ));
    getItemsByListId(listId: listId);
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