import 'package:flutter/material.dart';

///Text field for search value in list
class SearchTextField extends StatelessWidget {
  final TextEditingController searchValue;
  final IconButton suffixIconButton;
  final Icon prefixIcon;
  final Function(String) onChangedValue;
  final String labelText;

  const SearchTextField({
    super.key,
    required this.searchValue,
    required this.suffixIconButton,
    required this.onChangedValue,
    required this.labelText,
    required this.prefixIcon
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
  ///Input decoration for add prefixIcon,  suffixIcon, label
  InputDecoration searchInputDecoration({required BuildContext context}){
    return InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIconButton,
        labelText: labelText
    );
  }

}