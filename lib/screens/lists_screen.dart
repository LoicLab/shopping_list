import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/screens/add_list_screen.dart';
import 'package:shopping_list/screens/list_screen.dart';
import 'package:shopping_list/screens/modify_list_screen.dart';
import 'package:shopping_list/widgets/custom_dismissible.dart';
import 'package:shopping_list/widgets/custom_list_tile.dart';
import 'package:shopping_list/widgets/custom_scaffold.dart';
import 'package:shopping_list/widgets/custom_target_focus.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../providers/list_provider.dart';
import '../providers/tutorial_provider.dart';

///Screen for display all list
class ListsScreen extends StatelessWidget {
  final TargetPlatform platform;
  final String titleBar = 'Mes listes';
  final GlobalKey addListButtonKey = GlobalKey();
  final GlobalKey modifyListIconKey = GlobalKey();
  final GlobalKey consultListIconKey = GlobalKey();

  ListsScreen({super.key, required this.platform});

  @override
  Widget build(BuildContext context) {

    //Display the tutorial for the first start
    context.read<TutorialProvider>().initializeTutorial(
        context,
        [
          CustomTargetFocus(
              ContentAlign.left,
              "Cliquez ici pour créer une liste.",
              "Add list button",
              addListButtonKey
          ).build(context),
          CustomTargetFocus(
              ContentAlign.bottom,
              "Cliquez ici pour modifier la liste ou glissez vers la droite pour la supprimer.",
              "Modify list",
              modifyListIconKey,
          ).build(context),
          CustomTargetFocus(
            ContentAlign.bottom,
            "Cliquez ici pour accèder à la liste.",
            "Consult list",
            consultListIconKey,
          ).build(context)
        ],
        runtimeType.toString()
    );

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
          key: addListButtonKey,
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
                            key: index == 0 ? modifyListIconKey : null,
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
                        trailing: Icon(
                            key: index == 0 ? consultListIconKey : null,
                            Icons.arrow_forward_ios
                        ),
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