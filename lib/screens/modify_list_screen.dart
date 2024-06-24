import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/widgets/list_form.dart';

import '../providers/list_provider.dart';

class ModifyListScreen extends StatelessWidget {
  final TargetPlatform platform;
  final String titleBar;
  final int listId;
  final int index;

  const ModifyListScreen({
    super.key,
    required this.platform,
    required this.titleBar,
    required this.listId,
    required this.index
  });

  bool isAndroid() => (platform == TargetPlatform.android);

  Widget scaffold(BuildContext context) {
    return (isAndroid())
        ? Scaffold(
        appBar: AppBar(title: Text(titleBar), backgroundColor: Theme.of(context).colorScheme.primary),
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
        submitButton: ElevatedButton(
            onPressed: (){
              context.read<ListProvider>().update(listId: listId,index: index);
              Navigator.of(context).pop();
            },
            child: const Text('Modifier')
        ),
        index: index,
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<ListProvider>().getListById(listId: listId);
    return scaffold(context);
  }

}