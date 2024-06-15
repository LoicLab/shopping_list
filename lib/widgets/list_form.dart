import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/list_provider.dart';

class ListForm extends StatelessWidget {
  final ElevatedButton submitButton;
  const ListForm({super.key, required this.submitButton});

  @override
  Widget build(BuildContext context) {
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
                const Expanded(
                  child: TextField(
                    //controller: context.watch<ToDoProvider>().controller,
                    decoration: InputDecoration(hintText: "Ajouter"),
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
            submitButton
          ],
        ),
      ),
    );
  }
}