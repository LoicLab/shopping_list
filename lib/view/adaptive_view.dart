import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Defines the light themeClass used to manage the display of pages depending on whether you're on Android or iOS.
class AdaptiveView extends StatelessWidget{
  final TargetPlatform platform;
  final Widget view;
  final String titleBar;

  const AdaptiveView({
    super.key,
    required this.platform,
    required this.view,
    required this.titleBar
  });

  @override
  Widget build(BuildContext context) {
    return scaffold(context);
  }

  bool isAndroid() => (platform == TargetPlatform.android);

  Widget scaffold(BuildContext context) {
    return (isAndroid())
        ? Scaffold(appBar: appBar(context), body: body())
        : CupertinoPageScaffold(navigationBar: navBar(context),child: body());
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

  Widget body(){
    return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: view,
    );
  }
}