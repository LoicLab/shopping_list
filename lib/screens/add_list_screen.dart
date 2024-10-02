import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/providers/list_provider.dart';
import 'package:shopping_list/widgets/button_bottom.dart';
import 'package:shopping_list/widgets/custom_scaffold.dart';
import 'package:shopping_list/widgets/list_form.dart';

///Screen for add list
class AddListScreen extends StatelessWidget {
  final TargetPlatform platform;
  final String titleBar;

  const AddListScreen({
    super.key,
    required this.platform,
    required this.titleBar
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
    context.read<ListProvider>().resetList();
    return ListForm(
        formKey: formKey,
        submitButton: ButtonBottom(
            elevatedButton: ElevatedButton(
                onPressed: (){
                  if (formKey.currentState!.validate()) {
                    context.read<ListProvider>().add();
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Liste ajouter'))
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Le formulaire contient des erreurs'))
                    );
                  }
                },
                child: const Text('Créer')
            )
        )
    );
  }

}