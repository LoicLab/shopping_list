import 'core.dart';
import 'item.dart';

///List
class ItemList extends Core {
  @override
  DateTime? archivingDate;

  @override
  late DateTime creationDate;

  late int id;
  late String title;
  String? description;
  double totalPrice =0;
  List<Item>? items;

  ItemList({
    required this.id,
    required this.title,
    this.description,
    required this.creationDate,
    this.archivingDate,
    required this.totalPrice,
    this.items
  });
}