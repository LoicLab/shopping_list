import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/screens/add_list_screen.dart';
import 'package:shopping_list/screens/list_screen.dart';
import 'package:shopping_list/screens/modify_list_screen.dart';
import 'package:shopping_list/widgets/custom_dismissible.dart';
import 'package:shopping_list/widgets/custom_list_tile.dart';

import '../providers/list_provider.dart';

class ListsScreen extends StatelessWidget {
  final TargetPlatform platform;
  final titleBar = 'Mes listes';
  const ListsScreen({super.key, required this.platform});

  bool isAndroid() => (platform == TargetPlatform.android);

  Widget scaffold(BuildContext context) {
    return (isAndroid())
        ? Scaffold(
        appBar: AppBar(
            title: Text(titleBar, style: const TextStyle(color: Colors.white)),
            backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: body(context: context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext ctx){
                  return AddListScreen(platform: platform, titleBar: "Nouvelle liste");
                })
            );
          },
          child: const Icon(Icons.add),
        )
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
              separatorBuilder: ((context, index) => const Divider(color: Colors.white,)),
              itemCount: listProvider.lists.length
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(context);
  }

}