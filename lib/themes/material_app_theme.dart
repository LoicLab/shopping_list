import 'package:flutter/material.dart';

///Material theme
class MaterialAppTheme {

  ///Main color for app
  static const _mainColor = Colors.deepPurple;

  ///Material light theme
  static ThemeData lightTheme = ThemeData.light().copyWith(
      primaryColor: _mainColor,
      appBarTheme: const AppBarTheme(
          color: _mainColor,
          titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 22
          ),
          actionsIconTheme: IconThemeData(
              color: Colors.white
          ),
          iconTheme: IconThemeData(
            color: Colors.white
          )
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: _mainColor,
          foregroundColor: Colors.white
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: _mainColor
          )
      ),
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: _mainColor),
              borderRadius: BorderRadius.circular(50)
          ),
          labelStyle: const TextStyle(
              color: Colors.black
          ),
          hintStyle: const TextStyle(
              color: Colors.black
          ),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: _mainColor),
              borderRadius: BorderRadius.circular(50)
          )
      )
  );

  ///Material dark theme
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: _mainColor,
    appBarTheme: const AppBarTheme(
        color: Colors.deepPurple,
        actionsIconTheme: IconThemeData(
            color: Colors.white
        )
    ),
    inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: _mainColor),
            borderRadius: BorderRadius.circular(50)
        ),
        labelStyle: const TextStyle(
            color: Colors.white
        ),
        hintStyle: const TextStyle(
            color: Colors.white
        ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: _mainColor),
            borderRadius: BorderRadius.circular(50)
        )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: _mainColor
        )
    ),
    checkboxTheme: CheckboxThemeData(
      side: const BorderSide(
          color: Colors.white,
          width: 15
      ),
      fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return _mainColor;
        }
        return Colors.white;
      }),
    ),
  );
}