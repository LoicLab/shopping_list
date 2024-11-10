import 'package:flutter/material.dart';

class ButtonBottom extends StatelessWidget {

  final ElevatedButton elevatedButton;

  const ButtonBottom({
    super.key,
    required this.elevatedButton
  });

  @override
  Widget build(BuildContext context) {
     return Expanded(
         child: Align(
             alignment: Alignment.bottomCenter,
             child: Padding(
                 padding: const EdgeInsets.only(bottom: 8),
                 child: elevatedButton
             )
         )
     );
  }

}