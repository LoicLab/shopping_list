import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item_provider.dart';
import 'button_bottom.dart';
import 'custom_text_form_field.dart';

///Form for add or modify item
class ItemForm extends StatelessWidget {
  final ButtonBottom submitButton;
  final GlobalKey<FormState> formKey;

  const ItemForm({
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
                padding: const EdgeInsets.only(top: 15,left: 8, right: 8, bottom: 8),
                child: CustomTextFormField(
                  textEditingController:  context.watch<ItemProvider>().nameController,
                  label: "Nom",
                  textInputType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ce champ ne peut pas être vide';
                    }
                    return null;
                  }
                )
            ),
            Padding(
                padding: const EdgeInsets.all(8),
                child: CustomTextFormField(
                    textEditingController: context.watch<ItemProvider>().priceController,
                    label: "Prix",
                    textInputType: TextInputType.number
                )
            ),
            Padding(
                padding: const EdgeInsets.all(8),
                child: CustomTextFormField(
                    textEditingController: context.watch<ItemProvider>().shopController,
                    label: "Nom du magasin",
                    textInputType: TextInputType.text
                )
            ),
            Padding(
                padding: const EdgeInsets.only(top: 8,left: 15),
                child: Consumer<ItemProvider>(
                    builder: (context, itemProvider, child) => Stack(
                      children: [
                        Row(
                          children: [
                            const Text(
                                'Quantité',
                                style: TextStyle(
                                    fontSize: 18
                                )
                            ),
                            context.watch<ItemProvider>().quantityController.text == "1"
                                ? const Padding(padding: EdgeInsets.all(25))
                                : IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: itemProvider.decrementQuantity
                            ),
                            Text(
                                context.watch<ItemProvider>().quantityController.text
                            ),
                            IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: itemProvider.incrementQuantity
                            )
                          ],
                        )
                      ],
                    )
                )
            ),
            submitButton
          ],
        )
    );
  }

}