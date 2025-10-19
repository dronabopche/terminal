import 'package:flutter/material.dart';
import 'package:quantum_terminal/pages/theme_manager.dart'; // Fixed import path

class QuantumASCIIArt extends StatelessWidget {
  final TerminalTheme theme;

  const QuantumASCIIArt({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          theme.asciiArt,
          style: TextStyle(
            fontFamily: theme.fontFamily,
            color: theme.accentColor,
            fontSize: 10,
            height: 1.2,
            shadows: theme.textShadows,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Placeholder text',
          style: TextStyle(
            fontFamily: theme.fontFamily,
            color: theme.textColor,
            fontSize: 8,
            height: 1.1,
          ),
        ),
      ],
    );
  }
}
