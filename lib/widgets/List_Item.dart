import 'package:flutter/material.dart';
import './icon_button.dart';

class ListItem extends StatelessWidget {
  final Widget leading;
  final String title;
  final String subtitle;
  final IconButtons icon;
  const ListItem(this.leading, this.title, this.subtitle, this.icon,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xFF353A40),
          Color(0xFF32373D),
          Color(0xFF23282C),
        ]),
      ),
      child: ListTile(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(25),
          ),
        ),
        leading: leading,
        title: Text(
          title,
          style: theme.textTheme.titleSmall,
        ),
        subtitle: Text(
          subtitle,
          style: theme.textTheme.bodySmall,
        ),
        trailing: icon,
      ),
    );
  }
}
