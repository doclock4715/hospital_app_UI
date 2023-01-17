import 'package:flutter/material.dart';

class TimeActionChip extends StatelessWidget {
  final Color? bgColor;
  final String label;
  final VoidCallback? onPressed;
  const TimeActionChip(
      {super.key, required this.bgColor, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      backgroundColor: bgColor ?? Colors.grey[250],
      label: Text(label),
      onPressed: onPressed,
      disabledColor: Colors.grey[350],
    );
  }
}
