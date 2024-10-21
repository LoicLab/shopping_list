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
  final String titleBar = "Nouvel article";
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
             title: Text(titleBar),
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
    var formKey = GlobalKey<FormState>();
    context.read<ItemProvider>().resetItem();
    return ItemForm(
        formKey: formKey,
        submitButton: ButtonBottom(
            elevatedButton: ElevatedButton(
              onPressed: (){
                if (formKey.currentState!.validate()) {
                  context.read<ItemProvider>().addItemToList(listId: listId);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Article ajouté'))
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Le formulaire contient des erreurs'))
                  );
                }
              },
              child: const Text('Créer'),
            )
        )
    );
  }

}