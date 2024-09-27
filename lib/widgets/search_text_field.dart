import 'package:flutter/material.dart';

///Text field for search value in list
class SearchTextField extends StatelessWidget {
  final TextEditingController searchValue;
  final IconButton suffixIconButton;
  final Function(String) onChangedValue;
  final String labelText;

  const SearchTextField({
    super.key,
    required this.searchValue,
    required this.suffixIconButton,
    required this.onChangedValue,
    required this.labelText
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: searchInputDecoration(context: context),
        onChanged: onChangedValue,
        controller: searchValue ,
      ),
    );
  }
  ///Input decoration for add prefixIcon,  suffixIcon, label and border
  InputDecoration searchInputDecoration({required BuildContext context}){
    return InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        suffixIcon: suffixIconButton,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 0.0),
        )
    );
  }

}