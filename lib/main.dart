import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'controller/home_controller.dart';

void main() {
  runApp(MyApp());
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
        colorScheme: const ColorScheme.light(
          primary: Colors.deepPurple,
          secondary: Colors.black
        )
  );

  ///Defines the dark theme
  final ThemeData materialDarkTheme = ThemeData.dark().copyWith(
      colorScheme: const ColorScheme.light(
        primary: Colors.deepPurple,
        secondary: Colors.white
      )
  );
  
  final String title = "Title";

  MaterialApp androidBase({required TargetPlatform platform}){
    return MaterialApp(
      themeMode: ThemeMode.system,
      title: title,
      debugShowCheckedModeBanner: false,
      theme: materialTheme,
      darkTheme: materialDarkTheme,
      home: HomeController(
        platform: platform,
        titleBar: title
      )
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
      home: HomeController(
        platform: platform,
        titleBar: title
      )
    );
  }
}