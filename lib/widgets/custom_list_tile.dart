import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget? screen;

  const CustomListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.screen
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: (subtitle != null)?Text(subtitle!,style: const TextStyle(fontSize: 12),maxLines: 1):null,
      trailing: trailing,
      textColor: Theme.of(context).colorScheme.secondary,
      iconColor: Theme.of(context).colorScheme.secondary,
      onTap: () => onTap(context),
    );
  }

  onTap(context){
    if(screen != null){
      Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return screen!;
            },
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          )
      );
    }
  }

}