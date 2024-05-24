import 'package:shopping_list/model/core.dart';

///Item
class Item extends Core {
  @override
  DateTime? archivingDate;

  @override
  late DateTime creationDate;

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
}