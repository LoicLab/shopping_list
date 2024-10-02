import 'package:flutter/material.dart';

///Custom text form field
class CustomTextFormField extends StatelessWidget{
  final TextEditingController textEditingController;
  final String label;
  final TextInputType textInputType;
  final int? maxLines;
  final int? minLines;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.textEditingController,
    required this.label,
    required this.textInputType,
    this.maxLines,
    this.minLines,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textEditingController,
        validator: validator,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            label: Text(label)
        ),
        keyboardType: textInputType,
        maxLines: maxLines,
        minLines: minLines,
        textCapitalization: TextCapitalization.sentences
    );
  }
}