import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/widgets/button_bottom.dart';
import 'package:shopping_list/widgets/custom_text_field.dart';

import '../providers/list_provider.dart';

class ListForm extends StatelessWidget {
  final ButtonBottom submitButton;
  const ListForm({
    super.key,
    required this.submitButton,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: Colors.black45,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(15),
                child: CustomTextField(
                    textEditingController : context.watch<ListProvider>().titleController,
                    label: "Nom de la liste",
                    textInputType: TextInputType.text
                )
            ),
            Padding(
                padding: const EdgeInsets.all(15),
                child: CustomTextField(
                  textEditingController: context.watch<ListProvider>().descriptionController,
                  label: 'Description',
                  textInputType: TextInputType.multiline,
                  minLines: 2
              )
            ),
            submitButton
          ],
        ),
      ),
    );
  }
}