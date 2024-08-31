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
        confirmDismiss: (DismissDirection direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirmer la suppression"),
                content: const Text(
                    "Êtes-vous sûr de vouloir supprimer cet élément ? Cette action est irréversible."
                ),
                actions: <Widget> [
                  ElevatedButton(
                      onPressed:  () => Navigator.of(context).pop(true),
                      child: const Text("Supprimer")
                  ),
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("Annuler")
                  )
                ]
              );
            },
          );
        },
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