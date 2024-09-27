import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/screens/add_item_screen.dart';
import 'package:shopping_list/screens/modify_item_screen.dart';
import 'package:shopping_list/widgets/custom_scaffold.dart';
import 'package:shopping_list/widgets/search_text_field.dart';
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
          title: Text(titleBar),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
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
    if(context.watch<ItemsProvider>().filteredItems.isEmpty ){
      return Container(
        alignment: Alignment.center,
        child: const Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
                'Ajouter des articles dans votre liste.',
                style: TextStyle(fontSize: 20)
            ),
          ),
        ),
      );
    }
    return
      Column(
        children: [
          SearchTextField(
              searchValue: context.watch<ItemsProvider>().searchValue,
              suffixIconButton: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    context.read<ItemsProvider>().resetSearch();
                  }
              ),
              onChangedValue: (value) => context.read<ItemsProvider>().searchItems(query: value),
              labelText: 'Rechercher un article',
              prefixIcon: const Icon(Icons.search)
          ),
          Expanded(
              child: Consumer<ItemsProvider>(
              builder: (context, itemsProvider, child) => Stack(
                  children: [
                    ListView.separated(
                      separatorBuilder: ((context, index) => const Divider(color: Colors.white,)),
                      itemBuilder: (context, index) {
                      return CustomDismissible(
                          dismissibleKey: itemsProvider.filteredItems[index].id!.toString(),
                          onDismissed: (direction){
                            context.read<ItemsProvider>().removeItem(index: index);
                          },
                          listTile: CheckboxListTile(
                              secondary: IconButton(
                                  icon: const Icon(Icons.edit_note),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (BuildContext ctx){
                                          return ModifyItemScreen(
                                              item: itemsProvider.filteredItems[index],
                                              platform: platform
                                          );
                                        })
                                    );
                                  }
                              ),
                              title: Text(
                                  getTitleTile(item: itemsProvider.filteredItems[index])
                              ),
                              subtitle: Text(
                                  getSubtitleTile(item: itemsProvider.filteredItems[index])
                              ),
                              value: itemsProvider.filteredItems[index].status,
                              onChanged: (_) {
                                itemsProvider.updateItemStatus(index: index);
                              }
                          )
                      );
                    },
                    itemCount: itemsProvider.filteredItems.length,
                  )
                ],
              )
            )
          )
        ]
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