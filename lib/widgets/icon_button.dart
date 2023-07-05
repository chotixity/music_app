import 'package:flutter/material.dart';

class IconButtons extends StatelessWidget {
  final VoidCallback onpressed;
  final IconData icon;
  const IconButtons(this.onpressed, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onpressed,
      icon: Icon(icon),
      color: Colors.white,
      iconSize: 30,
    );
  }
}
