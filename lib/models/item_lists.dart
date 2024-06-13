import 'item_list.dart';

class ItemLists {
  List<ItemList>? _itemLists;

  void addItemList(ItemList itemList){
    _itemLists?.add(itemList);
  }

  List<ItemList>? get itemLists{
    return _itemLists;
  }

}