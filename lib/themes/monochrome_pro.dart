import 'package:flutter/material.dart';
import 'dart:math';

import 'package:quantum_terminal/pages/theme_manager.dart';

class MonochromeProTheme implements TerminalTheme {
  @override
  String get name => "MONOCHROME PRO";
  @override
  String get fontFamily => "IBM Plex Mono";
  @override
  Color get backgroundColor => const Color(0xFF000000);
  @override
  Color get textColor => const Color(0xFFFFFFFF);
  @override
  Color get accentColor => const Color(0xFFCCCCCC);
  @override
  Color get cursorColor => const Color(0xFFFFFFFF);
  @override
  Color get promptColor => const Color(0xFF888888);
  @override
  Color get errorColor => const Color(0xFF999999);
  @override
  Color get warningColor => const Color(0xFFBBBBBB);
  @override
  Color get successColor => const Color(0xFFFFFFFF);

  @override
  List<Shadow> get textShadows => [
        Shadow(color: Colors.white.withOpacity(0.1), blurRadius: 5),
      ];

  @override
  String get asciiArt => r'''
  ╔══════════════════════════════════════════════════╗
  ║  __  __  ___  _   _  ___  _   _  ___  ___  ___   ║
  ║ |  \/  |/ _ \| \ | |/ _ \| \ | |/ _ \|   \/ __|  ║
  ║ | |\/| | | | |  \| | | | |  \| | | | | |) \__ \  ║
  ║ | |  | | |_| | |\  | |_| | |\  | |_| | _ < |__/  ║
  ║ |_|  |_|\___/|_| \_|\___/|_| \_|\___/|_| \_\___| ║
  ╠══════════════════════════════════════════════════╣
  ║              QUANTUM TERMINAL v1.0               ║
  ║           MONOCHROME PRO THEME ACTIVE            ║
  ║             SYSTEM: OPTIMAL STATE                ║
  ╚══════════════════════════════════════════════════╝
  ''';

  @override
  String get welcomeMessage => '''
TERMINAL READY

System: Quantum Terminal Pro v1.0
Interface: Monochrome Professional
Status: All Systems Operational
Security: Maximum

Professional Mode: Active
Minimal Interface: Enabled
Performance: Optimal

Type 'help' for command list.
''';

  @override
  BoxDecoration get terminalDecoration => BoxDecoration(
        color: const Color(0xFF111111),
        border: Border.all(color: const Color(0xFF333333), width: 1),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      );

  // Math-generated monochrome background
  @override
  Widget get backgroundWidget => CustomPaint(
        painter: _MonochromeBackgroundPainter(),
        size: Size.infinite,
      );
}

class _MonochromeBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.0;

    // Draw minimalist grid
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint..color = Colors.white.withOpacity(0.03),
      );
    }

    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint..color = Colors.white.withOpacity(0.03),
      );
    }

    // Draw concentric circles
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final maxRadius = min(size.width, size.height) * 0.4;

    for (double r = 20; r < maxRadius; r += 30) {
      canvas.drawCircle(
        Offset(centerX, centerY),
        r,
        paint..color = Colors.white.withOpacity(0.02),
      );
    }

    // Draw binary data streams
    final rng = _SeededRandom(123);
    for (int i = 0; i < 150; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height;
      final length = rng.nextDouble() * 15 + 5;

      canvas.drawLine(
        Offset(x, y),
        Offset(x + length, y),
        paint..color = Colors.white.withOpacity(rng.nextDouble() * 0.1 + 0.05),
      );
    }

    // Draw technical patterns (dashed lines)
    for (double angle = 0; angle < pi * 2; angle += pi / 8) {
      final endX = centerX + cos(angle) * maxRadius;
      final endY = centerY + sin(angle) * maxRadius;

      canvas.drawLine(
        Offset(centerX, centerY),
        Offset(endX, endY),
        paint..color = Colors.white.withOpacity(0.04),
      );
    }

    // Draw data points (like on a radar)
    for (int i = 0; i < 50; i++) {
      final angle = rng.nextDouble() * pi * 2;
      final radius = rng.nextDouble() * maxRadius;
      final x = centerX + cos(angle) * radius;
      final y = centerY + sin(angle) * radius;

      canvas.drawCircle(
        Offset(x, y),
        1.0,
        paint..color = Colors.white.withOpacity(0.2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Add this class at the bottom of each theme file, before the last closing brace
class _SeededRandom {
  int _seed;

  _SeededRandom(this._seed);

  double nextDouble() {
    _seed = (_seed * 1103515245 + 12345) & 0x7fffffff;
    return (_seed >> 16) / 32767.0;
  }
}
