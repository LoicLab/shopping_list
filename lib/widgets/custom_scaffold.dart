import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Custom scaffold to take Material and Cupertino into account
class CustomScaffold extends StatelessWidget {
  final AppBar appBar;
  final CupertinoNavigationBar cupertinoNavigationBar;
  final Widget body;
  final TargetPlatform platform;
  final Widget? floatingActionButton;

  const CustomScaffold({
    super.key,
    required this.appBar,
    required this.cupertinoNavigationBar,
    required this.body,
    required this.platform,
    this.floatingActionButton
  });

  bool isAndroid() => (platform == TargetPlatform.android);

  @override
  Widget build(BuildContext context) {
    return (isAndroid())
        ? Scaffold(
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
    )
        : CupertinoPageScaffold(
        navigationBar: cupertinoNavigationBar,
        child: body
    );
  }

}