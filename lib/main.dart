import 'package:flutter/material.dart';
import 'package:quantum_terminal/themes/matrix_green.dart';
import 'pages/terminal_screen.dart';
import 'pages/theme_manager.dart';

void main() {
  runApp(const QuantumTerminalApp());
}

class QuantumTerminalApp extends StatefulWidget {
  const QuantumTerminalApp({super.key});

  @override
  State<QuantumTerminalApp> createState() => _QuantumTerminalAppState();
}

class _QuantumTerminalAppState extends State<QuantumTerminalApp> {
  TerminalTheme _currentTheme = MatrixGreenTheme();

  void _changeTheme(TerminalTheme newTheme) {
    setState(() {
      _currentTheme = newTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quantum Terminal v1.0',
      theme: ThemeData(
        fontFamily: _currentTheme
            .fontFamily, // This should work but might need fallback
        scaffoldBackgroundColor: _currentTheme.backgroundColor,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontFamily: _currentTheme.fontFamily),
          bodyLarge: TextStyle(fontFamily: _currentTheme.fontFamily),
          // ... other text styles
        ),
      ),
      home: TerminalScreen(
        currentTheme: _currentTheme,
        onThemeChange: _changeTheme,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
