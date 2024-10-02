import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/providers/item_provider.dart';
import 'package:shopping_list/widgets/custom_scaffold.dart';
import 'package:shopping_list/widgets/item_form.dart';

import '../models/item.dart';
import '../widgets/button_bottom.dart';

///Screen for modify item
class ModifyItemScreen extends StatelessWidget {

  final Item item;
  final TargetPlatform platform;

  const ModifyItemScreen({
    super.key,
    required this.item,
    required this.platform
  });

  @override
  Widget build(BuildContext context) {
      return CustomScaffold(
          appBar: AppBar(
              title: Text(item.name),
          ),
          cupertinoNavigationBar: CupertinoNavigationBar(
              middle: Text(item.name),
              backgroundColor: Theme.of(context).colorScheme.primary
          ),
          body: body(context: context),
          platform: platform
      );
  }

  Widget body({required BuildContext context}){
    var formKey = GlobalKey<FormState>();
    context.read<ItemProvider>().getItemById(itemId: item.id!);
    return ItemForm(
        formKey: formKey,
        submitButton: ButtonBottom(
            elevatedButton: ElevatedButton(
              onPressed: (){
                if (formKey.currentState!.validate()) {
                  context.read<ItemProvider>().updateItemToList(item: item);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Article modifier'))
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Le formulaire contient des erreurs'))
                  );
                }
              },
              child: const Text('Modifier'),
            )
        )
    );
  }

}