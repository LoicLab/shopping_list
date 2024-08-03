import 'package:flutter/material.dart';

class CustomDismissible extends StatelessWidget {

  final String dismissibleKey;
  final Function(DismissDirection)? onDismissed;
  final Widget listTile;


  const CustomDismissible({
    super.key,
    required this.dismissibleKey,
    required this.onDismissed,
    required this.listTile
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(dismissibleKey),
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
        child: listTile
    );
  }

}