import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{
  final TextEditingController textEditingController;
  final String label;
  final Color textColor;
  final TextInputType textInputType;
  final int? maxLines;
  final int? minLines;

  const CustomTextField({
    super.key,
    required this.textEditingController,
    required this.label,
    this.textColor = Colors.white,
    required this.textInputType,
    this.maxLines,
    this.minLines
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: textEditingController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(50)
            ),
            label: Text(
                label,
                style: TextStyle(color: textColor)
            )
        ),
        keyboardType: textInputType,
        maxLines: maxLines,
        minLines: minLines
    );
  }
}