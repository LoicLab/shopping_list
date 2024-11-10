import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/widgets/button_bottom.dart';
import 'package:shopping_list/widgets/custom_text_form_field.dart';

import '../providers/list_provider.dart';

class ListForm extends StatelessWidget {
  final ButtonBottom submitButton;
  final GlobalKey<FormState> formKey;

  const ListForm({
    super.key,
    required this.submitButton,
    required this.formKey
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(15),
              child: CustomTextFormField(
                  textEditingController: context.watch<ListProvider>().titleController,
                  label: "Nom de la liste",
                  textInputType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ce champ ne peut pas être vide';
                    }
                    return null;
                  })
          ),
          Padding(
              padding: const EdgeInsets.all(15),
              child: CustomTextFormField(
                  textEditingController: context.watch<ListProvider>().descriptionController,
                  label: 'Description',
                  textInputType: TextInputType.multiline,
                  minLines: 2
              )
          ),
          submitButton
        ],
      ),
    );
  }
}
