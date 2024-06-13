import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/providers/list_provider.dart';

class ListScreen extends StatelessWidget {
  final TargetPlatform platform;
  final String titleBar;

  const ListScreen({super.key, required this.platform, required this.titleBar});

  @override
  Widget build(BuildContext context) {
    return scaffold(context);
  }

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

  void dispose(){

  }

  Widget body({required BuildContext context}){

    return Card(
      margin: const EdgeInsets.all(8),
      color: Colors.black45,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
                controller: context.watch<ListProvider>().titleController,
                obscureText: false,
                decoration: const InputDecoration(
                    hintText: "Entrez le nom de la liste"
                ),
                keyboardType: TextInputType.text
            ),
            TextField(
                controller: context.watch<ListProvider>().descriptionController,
                obscureText: false,
                decoration: const InputDecoration(
                    hintText: "Entrez une description"
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 2
            ),
            const Text('Prix total :'),
            TextField(
              readOnly: true,
              obscureText: false,
              controller: context.watch<ListProvider>().totalPriceController,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    //controller: context.watch<ToDoProvider>().controller,
                    decoration: const InputDecoration(hintText: "Ajouter"),
                  ),

                ),
                IconButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      //context.read<ToDoProvider>().add();
                    },
                    icon: const Icon(Icons.send))
              ],
            ),
            const Divider(),
            /*         SingleChildScrollView(
              child:*/Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      //final String string = context.watch<ToDoProvider>().toDos[index];
                      return ListTile(
                        title: Text('test'),
                        trailing: IconButton(
                          //onPressed: (() => context.read<ToDoProvider>().remove(string)),
                          onPressed: (){

                          },
                          icon: Icon(Icons.delete),
                        ),
                      );
                    },
                    separatorBuilder: ((context, index) => const Divider()),
                    itemCount: 1//context.watch<ToDoProvider>().toDos.length)
                )
            ),
            /*   ),*/
            ElevatedButton(
                onPressed: (){
                  context.read<ListProvider>().add();
                  Navigator.of(context).pop();
                },
                child: const Text('Créér')
            )
          ],
        ),
      ),
    );
  }

}