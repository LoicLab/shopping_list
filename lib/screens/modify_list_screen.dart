import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/widgets/button_bottom.dart';
import 'package:shopping_list/widgets/custom_scaffold.dart';
import 'package:shopping_list/widgets/list_form.dart';

import '../providers/list_provider.dart';

///Screen for modify a list
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
    context.read<ListProvider>().getListById(listId: listId);
    return ListForm(
      submitButton: ButtonBottom(
          elevatedButton: ElevatedButton(
              onPressed: (){
                context.read<ListProvider>().update(listId: listId,index: index);
                Navigator.of(context).pop();
              },
              child: const Text('Modifier')
          )
      )
    );
  }

}