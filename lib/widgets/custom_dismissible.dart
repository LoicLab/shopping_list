import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/custom_list_tile.dart';

class CustomDismissible extends StatelessWidget {

  final int listId;
  final Function(DismissDirection)? onDismissed;
  final CustomListTile customListTile;


  const CustomDismissible({
    super.key,
    required this.listId,
    required this.onDismissed,
    required this.customListTile
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(listId.toString()),
        direction: DismissDirection.startToEnd,
        onDismissed: onDismissed,
        background: Container(
          padding: const EdgeInsets.only(right: 8),
          color: Colors.redAccent,
          child: const Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(Icons.delete,size: 30)
            ],
          ),
        ),
        child: customListTile
    );
  }

}