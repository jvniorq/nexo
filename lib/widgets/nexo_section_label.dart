import 'package:flutter/material.dart';

class NexoSectionLabel extends StatelessWidget {
  const NexoSectionLabel(
    this.text, {
    super.key,
    this.accent = false,
  });

  final String text;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      text,
      style: theme.textTheme.labelLarge?.copyWith(
        color: accent ? theme.colorScheme.primary : null,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      ),
    );
  }
}
