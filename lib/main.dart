import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/providers/item_provider.dart';
import 'package:shopping_list/providers/list_provider.dart';
import 'package:shopping_list/screens/lists_screen.dart';
import 'package:shopping_list/providers/items_provider.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_)=>ListProvider()),
            ChangeNotifierProvider(create: (_)=>ItemsProvider()),
            ChangeNotifierProvider(create: (_)=>ItemProvider())
          ],
          child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    //Just for test
    //const platform = TargetPlatform.android;
    bool isAndroid = (platform == TargetPlatform.android);
    return isAndroid ? androidBase(platform: platform) : iOSBase(platform: platform);
  }
  ///Defines the light theme
  final ThemeData materialTheme = ThemeData.light().copyWith(
      primaryColor: Colors.deepPurple,
      appBarTheme: const AppBarTheme(
          color: Colors.deepPurple,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22
          ),
          actionsIconTheme: IconThemeData(
              color: Colors.white
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // Couleur de la flèche de retour
          )
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.deepPurple
          )
      ),
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(50)
          ),
          labelStyle: const TextStyle(
              color: Colors.black
          ),
          hintStyle: const TextStyle(
              color: Colors.black
          ),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(50)
          )
      )
  );

  ///Defines the dark theme
  final ThemeData materialDarkTheme = ThemeData.dark().copyWith(
      primaryColor: Colors.deepPurple,
      appBarTheme: const AppBarTheme(
        color: Colors.deepPurple,
        actionsIconTheme: IconThemeData(
          color: Colors.white
        )
      ),
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(50)
          ),
          labelStyle: const TextStyle(
              color: Colors.white
          ),
          hintStyle: const TextStyle(
              color: Colors.white
          ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(50)
        )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.deepPurple
          )
      ),
      checkboxTheme: CheckboxThemeData(
          side: const BorderSide(
            color: Colors.white,
              width: 15
          ),
          fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.deepPurple;
            }
            return Colors.white;
          }),
      ),
  );

  final String title = "Liste de courses";

  MaterialApp androidBase({required TargetPlatform platform}){
    return MaterialApp(
        themeMode: ThemeMode.system,
        title: title,
        debugShowCheckedModeBanner: false,
        theme: materialTheme,
        darkTheme: materialDarkTheme,
        home: ListsScreen(platform: platform)
    );
  }

  CupertinoApp iOSBase({required TargetPlatform platform}){
    return CupertinoApp(
        title: title,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate
        ],
        theme: CupertinoThemeData(
            primaryColor: materialTheme.primaryColor
        ),
        home: ListsScreen(platform: platform)
    );
  }
}