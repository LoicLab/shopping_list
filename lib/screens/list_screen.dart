import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/items_provider.dart';

class ListScreen extends StatelessWidget {
  final TargetPlatform platform;
  final String titleBar;
  final int listId;

  const ListScreen({
    super.key,
    required this.listId,
    required this.platform,
    required this.titleBar
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
    if(context.watch<ItemsProvider>().items.isEmpty ){
      return Container(
        alignment: Alignment.center,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
                'Aucun article dans cette liste.',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 20
                )
            ),
          ),
        ),
      );
    }
    return Consumer<ItemsProvider>(
        builder: (context, itemsProvider, child) => Stack(
          children: [
            ListView.separated(
              separatorBuilder: ((context, index) => const Divider(color: Colors.white,)),
              itemBuilder: (context, index) {
                return CheckboxListTile(
                    title: Text(
                        itemsProvider.items[index].name,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary
                        )
                    ),
                    value: itemsProvider.items[index].status,
                    onChanged: (_) => itemsProvider.updateItemStatus(index: index),
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 15
                    ),

                );
              },
              itemCount: itemsProvider.items.length,
            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<ItemsProvider>().getItemsByListId(listId: listId);
    return scaffold(context);
  }

}