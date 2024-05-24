import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Defines the light themeClass used to manage the display of pages depending on whether you're on Android or iOS.
class AdaptiveScreen extends StatelessWidget{
  final TargetPlatform platform;
  final String titleBar;

  const AdaptiveScreen({
    super.key,
    required this.platform,
    required this.titleBar
  });

  @override
  Widget build(BuildContext context) {
    return scaffold(context);
  }

  bool isAndroid() => (platform == TargetPlatform.android);

  Widget scaffold(BuildContext context) {
    return (isAndroid())
        ? Scaffold(appBar: appBar(context), body: body(context: context))
        : CupertinoPageScaffold(navigationBar: navBar(context),child: body(context: context));
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
        title: Text(titleBar),
        backgroundColor: Theme.of(context).colorScheme.primary
    );
  }

  CupertinoNavigationBar navBar(BuildContext context) {
    return CupertinoNavigationBar(
        middle: Text(titleBar),
        backgroundColor: Theme.of(context).colorScheme.primary
    );
  }

  Widget body({required BuildContext context}){
    return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text('Adaptive theme',style: TextStyle(color: Theme.of(context).colorScheme.secondary),)
    );
  }
}