import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/providers/item_provider.dart';
import 'package:shopping_list/widgets/button_bottom.dart';
import 'package:shopping_list/widgets/custom_scaffold.dart';
import 'package:shopping_list/widgets/custom_text_field.dart';

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
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 15,left: 8, right: 8, bottom: 8),
            child: CustomTextField(
                textEditingController:  context.watch<ItemProvider>().nameController,
                label: "Nom",
                textInputType: TextInputType.text
            )
        ),
        Padding(
            padding: const EdgeInsets.all(8),
            child: CustomTextField(
                textEditingController: context.watch<ItemProvider>().priceController,
                label: "Prix",
                textInputType: TextInputType.number
            )
        ),
        Padding(
            padding: const EdgeInsets.all(8),
            child: CustomTextField(
                textEditingController: context.watch<ItemProvider>().shopController,
                label: "Nom du magasin",
                textInputType: TextInputType.text
            )
        ),
        ButtonBottom(
            elevatedButton: ElevatedButton(
              onPressed: (){
                context.read<ItemProvider>().addItemToList(listId: listId);
                Navigator.of(context).pop();
              },
              child: const Text('Créer'),
            )
        )
      ],
    );
  }

}