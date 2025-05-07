import 'package:flutter/material.dart';

class AppBarAction extends StatelessWidget {
  const AppBarAction({
    super.key, required this.icon, required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
            radius: 17,
            backgroundColor: Colors.grey.withOpacity(0.3),
            child: Icon(icon,size: 16,)
        ),
      ),
    );
  }
}