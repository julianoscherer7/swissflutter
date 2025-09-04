import 'package:flutter/material.dart';

class ToolIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;

  const ToolIcon({
    super.key,
    required this.icon,
    required this.color,
    this.size = 32.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }
}