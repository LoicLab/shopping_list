import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/widgets/custom_dismissible.dart';
import 'package:shopping_list/widgets/custom_list_tile.dart';

import '../models/item.dart';
import '../providers/list_provider.dart';

class ListForm extends StatelessWidget {
  final ElevatedButton submitButton;
  final int? index;
  const ListForm({super.key, required this.submitButton, this.index});

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
                    hintText: "Entrer le nom de la liste"
                ),
                keyboardType: TextInputType.text
            ),
            TextField(
                controller: context.watch<ListProvider>().descriptionController,
                obscureText: false,
                decoration: const InputDecoration(
                    hintText: "Entrer une description"
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
                  child: Column(
                    children: [
                      TextField(
                        controller: context.watch<ListProvider>().itemNameController,
                        decoration: const InputDecoration(hintText: "Nom de l'article"),
                      ),
                      TextField(
                          controller: context.watch<ListProvider>().itemPriceController,
                          decoration: const InputDecoration(hintText: "Prix de l'article"),
                          keyboardType: TextInputType.number
                      )
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      context.read<ListProvider>().addItemToList(index: index!);
                    },
                    icon: const Icon(Icons.send))
              ],
            ),
            const Divider(),
            Expanded(
              child: Consumer<ListProvider>(
                builder: (context,listProvider,child)=>Stack(
                  children: [
                    ListView.separated(
                        itemBuilder: (context, index) {
                          final Item item = listProvider.items[index];
                          return CustomDismissible(
                              listId: item.id!,
                              onDismissed: (direction){
                                context.read<ListProvider>().removeItem(item: item);
                              },
                              customListTile: CustomListTile(title: item.name)
                          );
                        },
                        separatorBuilder: ((context, index) => const Divider()),
                        itemCount: listProvider.items.length
                    )

                  ],
                ),
              ),
            ),
            submitButton
          ],
        ),
      ),
    );
  }
}