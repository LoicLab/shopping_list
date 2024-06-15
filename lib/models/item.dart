import 'core.dart';

///Item
class Item extends Core {
  @override
  DateTime? archivingDate;

  @override
  late DateTime? creationDate;

  late int id;
  late String name;
  double? price;
  String? shop;
  late bool status;
  late int itemListId;

  Item({
    required this.id,
    required this.name,
    this.price,
    this.shop,
    required this.status,
    required this.creationDate,
    this.archivingDate,
    required this.itemListId
  });

  Item.fromMap(Map<String, dynamic> map):
        id = map["id"],
        name = map["name"],
        price = map["price"],
        shop = map["shop"],
        status = map["status"],
        creationDate = map["creation_date"],
        archivingDate = map["archiving_date"];

}