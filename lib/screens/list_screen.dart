import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/screens/add_item_screen.dart';
import 'package:shopping_list/screens/modify_item_screen.dart';
import 'package:shopping_list/widgets/custom_scaffold.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../models/item.dart';
import '../providers/items_provider.dart';
import '../widgets/custom_dismissible.dart';

///Screen for display a list
class ListScreen extends StatelessWidget {
  final TargetPlatform platform;
  final String titleBar;
  final int listId;

  ListScreen({
    super.key,
    required this.listId,
    required this.platform,
    required this.titleBar
  }){
    // No screen lock
    WakelockPlus.enable();
  }

  @override
  Widget build(BuildContext context){
    return CustomScaffold(
        appBar: AppBar(
          title: Text(titleBar, style: const TextStyle(color: Colors.white)),
          backgroundColor: Theme.of(context).colorScheme.primary,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext ctx){
                      return AddItemScreen(platform: platform, listId: listId);
                    })
                );
              },
            )
          ],
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
    context.read<ItemsProvider>().getItemsByListId(listId: listId);
    if(context.watch<ItemsProvider>().items.isEmpty ){
      return Container(
        alignment: Alignment.center,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
                'Ajouter des articles dans votre liste.',
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
                return CustomDismissible(
                    dismissibleKey: itemsProvider.items[index].id!.toString(),
                    onDismissed: (direction){
                      context.read<ItemsProvider>().removeItem(index: index);
                    },
                    listTile: CheckboxListTile(
                        secondary: IconButton(
                            icon: Icon(
                                Icons.edit_note,
                                color: Theme.of(context).colorScheme.secondary
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (BuildContext ctx){
                                    return ModifyItemScreen(
                                        item: itemsProvider.items[index],
                                        platform: platform
                                    );
                                  })
                              );
                            }
                        ),
                        title: Text(
                            getTitleTile(item: itemsProvider.items[index]),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary
                            )
                        ),
                        subtitle: Text(
                            getSubtitleTile(item: itemsProvider.items[index]),
                            style: TextStyle(color: Theme.of(context).colorScheme.secondary)
                        ),
                        value: itemsProvider.items[index].status,
                        onChanged: (_) => itemsProvider.updateItemStatus(index: index),
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 15
                        )
                    )
                );
              },
              itemCount: itemsProvider.items.length,
            )
          ],
        )
    );
  }
  ///Get title with quantity or not
  String getTitleTile({required Item item}){
    return (item.quantity == null)
        ?item.name
        :'${item.name} x ${item.quantity}';
  }

  String getSubtitleTile({required Item item}){
    String subtitleTile = "";
    if(item.price != null){ subtitleTile = item.getPriceToString(); }
    if(item.shop != null){
      if(subtitleTile.isEmpty == false){
        subtitleTile += ' ${ ' / ${item.shop!}'}';
      }else{
        subtitleTile = item.shop!;
      }
    }
    return subtitleTile;
  }
}