import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item_provider.dart';
import 'button_bottom.dart';
import 'custom_text_field.dart';

///Form for add or modify item
class ItemForm extends StatelessWidget {
  final ButtonBottom submitButton;

  const ItemForm({
    super.key,
    required this.submitButton
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 15,left: 8, right: 8, bottom: 8),
            child: CustomTextField(
                textEditingController:  context.watch<ItemProvider>().nameController,
                label: "Nom",
                textInputType: TextInputType.text
            )
        ),
        Padding(
            padding: const EdgeInsets.all(8),
            child: CustomTextField(
                textEditingController: context.watch<ItemProvider>().priceController,
                label: "Prix",
                textInputType: TextInputType.number
            )
        ),
        Padding(
            padding: const EdgeInsets.all(8),
            child: CustomTextField(
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
                      itemProvider.quantityController.text == "1"
                      ? const Padding(padding: EdgeInsets.all(25))
                      : IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: itemProvider.decrementQuantity
                      ),
                      Text(
                          itemProvider.quantityController.text
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
    );
  }

}