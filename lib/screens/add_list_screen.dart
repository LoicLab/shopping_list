import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/providers/list_provider.dart';
import 'package:shopping_list/widgets/button_bottom.dart';
import 'package:shopping_list/widgets/list_form.dart';

class AddListScreen extends StatelessWidget {
  final TargetPlatform platform;
  final String titleBar;

  const AddListScreen({
    super.key,
    required this.platform,
    required this.titleBar
  });

  bool isAndroid() => (platform == TargetPlatform.android);

  Widget scaffold(BuildContext context) {
    return (isAndroid())
        ? Scaffold(
        appBar: AppBar(
            title: Text(titleBar, style: const TextStyle(color: Colors.white)),
            backgroundColor: Theme.of(context).colorScheme.primary
        ),
        body: body(context: context)
    )
        : CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            middle: Text(titleBar),
            backgroundColor: Theme.of(context).colorScheme.primary
        ),
        child: body(context: context)
    );
  }

  Widget body({required BuildContext context}){
    return ListForm(
        submitButton: ButtonBottom(
          elevatedButton: ElevatedButton(
              onPressed: (){
                context.read<ListProvider>().add();
                Navigator.of(context).pop();
              },
              child: const Text('Créer')
          )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<ListProvider>().resetList();
    return scaffold(context);
  }

}