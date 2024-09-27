import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/screens/add_list_screen.dart';
import 'package:shopping_list/screens/list_screen.dart';
import 'package:shopping_list/screens/modify_list_screen.dart';
import 'package:shopping_list/widgets/custom_dismissible.dart';
import 'package:shopping_list/widgets/custom_list_tile.dart';
import 'package:shopping_list/widgets/custom_scaffold.dart';

import '../providers/list_provider.dart';

///Screen for display all list
class ListsScreen extends StatelessWidget {
  final TargetPlatform platform;
  final titleBar = 'Mes listes';
  const ListsScreen({super.key, required this.platform});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: AppBar(
          title: Text(titleBar)
        ),
        platform: platform,
        cupertinoNavigationBar: CupertinoNavigationBar(
            middle: Text(titleBar),
            backgroundColor: Theme.of(context).colorScheme.primary
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext ctx){
                  return AddListScreen(platform: platform, titleBar: "Nouvelle liste");
                })
            );
          },
          child: const Icon(Icons.add),
        ),
        body: body()
    );
  }

  Widget body(){
    //Consumer for notify that the list of list it's changed
    return Consumer<ListProvider>(
      builder: (context, listProvider, child) => Stack(
        children: [
          ListView.separated(
              itemBuilder: (context, index) {
                final list = listProvider.lists[index];
                return CustomDismissible(
                    dismissibleKey: list.id!.toString(),
                    onDismissed: (direction){
                      context.read<ListProvider>().remove(listId: list.id!, index: index);
                    },
                    listTile: CustomListTile(
                        title: list.title,
                        subtitle: list.description,
                        leading: IconButton(
                            icon: const Icon(Icons.edit_note),
                            onPressed: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (BuildContext ctx){
                                    return ModifyListScreen(
                                        platform: platform,
                                        titleBar: list.title,
                                        listId: list.id!,
                                        index: index
                                    );
                                  })
                              );
                            }
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        screen: ListScreen(
                            listId: list.id!,
                            platform: platform,
                            titleBar: list.title
                        )
                    )
                );
              },
              separatorBuilder: ((context, index) => const Divider()),
              itemCount: listProvider.lists.length
          )
        ],
      ),
    );
  }
}