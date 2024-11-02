import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/providers/list_provider.dart';
import 'package:shopping_list/providers/tutorial_provider.dart';
import 'package:shopping_list/screens/lists_screen.dart';
import 'package:shopping_list/providers/items_provider.dart';
import 'package:shopping_list/themes/material_app_theme.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_)=>ListProvider()),
            ChangeNotifierProvider(create: (_)=>ItemsProvider()),
            ChangeNotifierProvider(create: (_)=>TutorialProvider())
          ],
          child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    //Just for test
    //const platform = TargetPlatform.android;
    bool isAndroid = (platform == TargetPlatform.android);
    return isAndroid ? androidBase(platform: platform) : iOSBase(platform: platform);
  }

  final String title = "Liste de courses";

  MaterialApp androidBase({required TargetPlatform platform}){
    return MaterialApp(
        themeMode: ThemeMode.system,
        title: title,
        debugShowCheckedModeBanner: false,
        theme: MaterialAppTheme.lightTheme,
        darkTheme: MaterialAppTheme.darkTheme,
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
            primaryColor: MaterialAppTheme.lightTheme.primaryColor
        ),
        home: ListsScreen(platform: platform)
    );
  }
}