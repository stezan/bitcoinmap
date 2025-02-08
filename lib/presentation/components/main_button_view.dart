import 'package:flutter/material.dart';

class MainButtonView extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? icon;

  const MainButtonView({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      onPressed: onPressed,
      icon: icon != null
          ? Icon(
              icon,
              color: Theme.of(context).colorScheme.onPrimary,
            )
          : const SizedBox.shrink(),
      label: Text(text),
    );
  }
}
