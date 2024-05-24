import 'package:flutter/material.dart';
import '../view/adaptive_view.dart';

class HomeController extends StatelessWidget {

  final TargetPlatform platform;
  final String titleBar;

  const HomeController({
    super.key,
    required this.platform,
    required this.titleBar
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveView(
          platform: platform,
          titleBar: titleBar,
          view:  Text('Adaptive theme',style: TextStyle(color: Theme.of(context).colorScheme.secondary),)
      );
  }
}