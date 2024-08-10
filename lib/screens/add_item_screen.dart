import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/providers/item_provider.dart';
import 'package:shopping_list/widgets/button_bottom.dart';
import 'package:shopping_list/widgets/custom_scaffold.dart';
import 'package:shopping_list/widgets/item_form.dart';

///Screen for add item to list
class AddItemScreen extends StatelessWidget {
  final TargetPlatform platform;
  final String titleBar = "Nouvelle article";
  final int listId;

  const AddItemScreen({
    super.key,
    required this.platform,
    required this.listId
  });

  @override
  Widget build(BuildContext context){
     return CustomScaffold(
         appBar: AppBar(
             title: Text(titleBar, style: const TextStyle(color: Colors.white)),
             backgroundColor: Theme.of(context).colorScheme.primary
         ),
         cupertinoNavigationBar: CupertinoNavigationBar(
             middle: Text(titleBar),
             backgroundColor: Theme.of(context).colorScheme.primary
         ),
         body: body(context: context),
         platform: platform
     );
  }

  Widget body({required BuildContext context}){
    context.read<ItemProvider>().resetItem();
    return ItemForm(
        submitButton: ButtonBottom(
            elevatedButton: ElevatedButton(
              onPressed: (){
                context.read<ItemProvider>().addItemToList(listId: listId);
                Navigator.of(context).pop();
              },
              child: const Text('Créer'),
            )
        )
    );
  }

}