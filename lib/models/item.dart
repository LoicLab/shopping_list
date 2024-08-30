import 'core.dart';

///Item
class Item extends Core {
  @override
  DateTime? archivingDate;

  @override
  late DateTime? creationDate;

  late int? id;
  late String name;
  double? price;
  String? shop;
  late bool status;
  late int itemListId;
  int? quantity;

  Item({
    this.id,
    required this.name,
    this.price,
    this.shop,
    required this.status,
    required this.creationDate,
    this.archivingDate,
    required this.itemListId,
    this.quantity
  });

  ///Return price to string with the €
  String getPriceToString(){
    return '$price €';
  }

  Item.fromMap(Map<String, dynamic> map, int listId):
        id = map["id"],
        name = map["name"],
        price = map["price"],
        shop = map["shop"],
        status = map["status"] == 0 ? false : true,
        creationDate = DateTime.tryParse(map["creation_date"]),
        quantity = map["quantity"],
        itemListId = listId;
        //archivingDate = map["archiving_date"];

}