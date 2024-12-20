import 'core.dart';
import 'item.dart';

///List
class ItemList extends Core {
  @override
  DateTime? archivingDate;

  @override
  DateTime? creationDate;

  late int? id;
  late String title;
  String description;
  double totalPrice =0;
  List<Item>? items;

  ItemList({
    this.id,
    required this.title,
    required this.description,
    this.creationDate,
    this.archivingDate,
    required this.totalPrice,
    this.items
  });
  ///Add item to list
  addItem({required Item item}){
      items ??= [];
      items?.add(item);
  }
  ///Remove item to list
  removeItem({required Item item}){
    if(items == null) return;
    items?.remove(item);
  }

  ItemList.fromMap(Map<String, dynamic> map):
        id = map["id"],
        title = map["title"],
        description = map["description"],
        totalPrice = map["total_price"],
        //items = map["items"],
        creationDate = DateTime.tryParse(map["creation_date"])!;
        //archivingDate = map["archiving_date"];
}