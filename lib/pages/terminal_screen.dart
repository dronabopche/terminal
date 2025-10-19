import 'package:flutter/material.dart';
import 'package:quantum_terminal/pages/theme_manager.dart';
import 'package:quantum_terminal/themes/matrix_green.dart';
import 'package:quantum_terminal/themes/monochrome_pro.dart';
import 'package:quantum_terminal/themes/neon_cyber.dart';
import 'package:quantum_terminal/themes/quantum_blue.dart';
import '../widgets/terminal_interface.dart';
import '../widgets/ascii_art.dart';

class TerminalScreen extends StatefulWidget {
  final TerminalTheme currentTheme;
  final Function(TerminalTheme) onThemeChange;

  const TerminalScreen({
    super.key,
    required this.currentTheme,
    required this.onThemeChange,
  });

  @override
  State<TerminalScreen> createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen>
    with SingleTickerProviderStateMixin {
  final List<TerminalTheme> _themes = [
    MatrixGreenTheme(),
    QuantumBlueTheme(),
    NeonCyberTheme(),
    MonochromeProTheme(),
  ];

  int _currentThemeIndex = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _cycleTheme() {
    setState(() {
      _currentThemeIndex = (_currentThemeIndex + 1) % _themes.length;
      widget.onThemeChange(_themes[_currentThemeIndex]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.currentTheme.backgroundColor,
      body: Stack(
        children: [
          // Math-generated background for all themes
          widget.currentTheme.backgroundWidget,

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Theme switcher
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: _cycleTheme,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: widget.currentTheme.accentColor),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'THEME: ${widget.currentTheme.name}',
                            style: TextStyle(
                              color: widget.currentTheme.accentColor,
                              fontSize: 12,
                              shadows: widget.currentTheme.textShadows,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ASCII Art Header
                QuantumASCIIArt(theme: widget.currentTheme),

                const SizedBox(height: 30),

                // Terminal Interface
                Expanded(
                  child: TerminalInterface(theme: widget.currentTheme),
                ),

                // Footer
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Quantum Terminal v1.0 • ${widget.currentTheme.name}',
                    style: TextStyle(
                      color: widget.currentTheme.textColor.withOpacity(0.5),
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
