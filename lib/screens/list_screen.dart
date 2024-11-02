import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/screens/add_item_screen.dart';
import 'package:shopping_list/screens/modify_item_screen.dart';
import 'package:shopping_list/widgets/custom_scaffold.dart';
import 'package:shopping_list/widgets/search_text_field.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../models/item.dart';
import '../providers/items_provider.dart';
import '../providers/tutorial_provider.dart';
import '../widgets/custom_dismissible.dart';
import '../widgets/custom_target_focus.dart';

///Screen for display a list
class ListScreen extends StatelessWidget {
  final TargetPlatform platform;
  final String titleBar;
  final int listId;
  final GlobalKey addItemButtonKey = GlobalKey();
  final GlobalKey deleteItemsButtonKey = GlobalKey();

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

    //Display the tutorial for the first start
    context.read<TutorialProvider>().initializeTutorial(
        context,
        [
          CustomTargetFocus(
              ContentAlign.bottom,
              "Cliquez ici pour ajouter un article à votre liste.",
              "Add item button",
              addItemButtonKey
          ).build(context),
          CustomTargetFocus(
              ContentAlign.bottom,
              "Cliquez ici pour vider la liste des articles.",
              "Delete items button",
              deleteItemsButtonKey
          ).build(context)
        ],
        runtimeType.toString()
    );

    final itemsProvider = Provider.of<ItemsProvider>(context, listen: false);

    return CustomScaffold(
              appBar: AppBar(
                title: Text(titleBar),
                actions: <Widget>[
                  IconButton(
                    key: deleteItemsButtonKey,
                    icon: const Icon(Icons.delete_forever),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: const Text("Confirmer la suppression"),
                              content: const Text(
                                  "Êtes-vous sûr de vouloir vider la liste ? Cette action est irréversible."
                              ),
                              actions: <Widget> [
                                ElevatedButton(
                                    onPressed: () {
                                      itemsProvider.emptyList(listId: listId);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Vider la liste")
                                ),
                                ElevatedButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text("Annuler")
                                )
                              ]
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    key: addItemButtonKey,
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
              body: body(context: context, itemsProvider: itemsProvider),
              platform: platform
          );

  }

  Widget body({required BuildContext context, required ItemsProvider itemsProvider}){
    //Future builder for call asynchrone getItemsByListId
    return FutureBuilder(
        future: itemsProvider.getItemsByListId(listId: listId),
        builder: (context, snapshot) {
          if(context.watch<ItemsProvider>().filteredItems.isEmpty){
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
              children: [
                SearchTextField(
                    searchValue: itemsProvider.searchValue,
                    suffixIconButton: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          itemsProvider.resetSearch();
                        }
                    ),
                    onChangedValue: (value) => itemsProvider.searchItems(query: value),
                    labelText: 'Rechercher un article',
                    prefixIcon: const Icon(Icons.search)
                ),
                Expanded(child: _showItemsList() )
              ]
          );
        }
    );
  }
  ///Show the list of items with a consumer
  Consumer<ItemsProvider> _showItemsList(){
    return Consumer<ItemsProvider>(
        builder: (context, itemsProvider, child) => Stack(
          children: [
            ListView.separated(
              separatorBuilder: ((context, index) => const Divider()),
              itemBuilder: (context, index) {
                final items = itemsProvider.filteredItems;
                return CustomDismissible(
                    dismissibleKey: items[index].id!.toString(),
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
                                        item: items[index],
                                        platform: platform
                                    );
                                  })
                              );
                            }
                        ),
                        title: Text(
                            getTitleTile(item: items[index])
                        ),
                        subtitle: Text(
                            getSubtitleTile(item: items[index])
                        ),
                        value: items[index].status,
                        onChanged: (_) {
                          itemsProvider.updateItemStatus(index: index);
                        }
                    )
                );
              },
              itemCount: itemsProvider.filteredItems.length,
            )
          ]
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