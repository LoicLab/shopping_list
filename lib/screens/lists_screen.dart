import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/screens/add_list_screen.dart';
import 'package:shopping_list/screens/modify_list_screen.dart';

import '../providers/list_provider.dart';

class ListsScreen extends StatelessWidget {
  final TargetPlatform platform;
  final titleBar = 'Mes listes';
  const ListsScreen({super.key, required this.platform});

  bool isAndroid() => (platform == TargetPlatform.android);

  Widget scaffold(BuildContext context) {
    return (isAndroid())
        ? Scaffold(
        appBar: AppBar(title: Text(titleBar), backgroundColor: Theme.of(context).colorScheme.primary),
        body: body(context: context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext ctx){
                  //return ListScreen(platform: platform,titleBar: "Ajout d'une liste");
                  return AddListScreen(platform: platform, titleBar: "Ajout d'une liste");
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
                return ListTile(
                    title: Text(list.title),
                    subtitle: Text(list.description,style: const TextStyle(fontSize: 12),maxLines: 1),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    textColor: Theme.of(context).colorScheme.secondary,
                    iconColor: Theme.of(context).colorScheme.secondary,
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext ctx){
                            return ModifyListScreen(platform: platform, titleBar: titleBar, listId: list.id!);
                          })
                      );
                    }
                );
              },
              separatorBuilder: ((context, index) => const Divider()),
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