import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quantum_terminal/pages/theme_manager.dart';
import 'dart:math';

class MatrixGreenTheme implements TerminalTheme {
  @override
  String get name => "MATRIX GREEN";
  @override
  String get fontFamily => "JetBrains Mono";
  @override
  Color get backgroundColor => const Color(0xFF0A0A0A);
  @override
  Color get textColor => const Color(0xFF00FF41);
  @override
  Color get accentColor => const Color(0xFF00FF41);
  @override
  Color get cursorColor => const Color(0xFF00FF41);
  @override
  Color get promptColor => const Color(0xFF00FF00);
  @override
  Color get errorColor => const Color(0xFFFF4444);
  @override
  Color get warningColor => const Color(0xFFFFFF00);
  @override
  Color get successColor => const Color(0xFF00FF88);

  @override
  List<Shadow> get textShadows => [
        Shadow(color: const Color(0xFF00FF41).withOpacity(0.8), blurRadius: 12),
        Shadow(color: const Color(0xFF00FF41).withOpacity(0.4), blurRadius: 24),
      ];

  @override
  String get asciiArt => r'''
  ╔══════════════════════════════════════════════════╗
  ║ ███╗   ███╗ █████╗ ████████╗██████╗ ██╗██╗  ██╗ ║
  ║ ████╗ ████║██╔══██╗╚══██╔══╝██╔══██╗██║╚██╗██╔╝ ║
  ║ ██╔████╔██║███████║   ██║   ██████╔╝██║ ╚███╔╝  ║
  ║ ██║╚██╔╝██║██╔══██║   ██║   ██╔══██╗██║ ██╔██╗  ║
  ║ ██║ ╚═╝ ██║██║  ██║   ██║   ██║  ██║██║██╔╝ ██╗ ║
  ║ ╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝ ║
  ╠══════════════════════════════════════════════════╣
  ║             QUANTUM TERMINAL v1.0                ║
  ║           MATRIX GREEN THEME ACTIVE              ║
  ║             SYSTEM INITIALIZED...                ║
  ╚══════════════════════════════════════════════════╝
  ''';

  @override
  String get welcomeMessage => '''
WELCOME TO MATRIX GREEN TERMINAL

System: Quantum OS v2.1.4
Theme: Neo-Matrix Protocol
Status: All systems operational
Security: Quantum Encryption Active

Type 'help' for available commands.
''';

  @override
  BoxDecoration get terminalDecoration => BoxDecoration(
        border: Border.all(
          color: const Color(0xFF00FF41).withOpacity(0.5),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00FF41).withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      );

  // Math-generated background
  Widget get backgroundWidget => CustomPaint(
        painter: _MatrixBackgroundPainter(accentColor),
        size: Size.infinite,
      );
}

class _MatrixBackgroundPainter extends CustomPainter {
  final Color baseColor;

  _MatrixBackgroundPainter(this.baseColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = baseColor.withOpacity(0.1)
      ..strokeWidth = 1.0;

    // Draw falling code rain (Matrix-style)
    for (double x = 0; x < size.width; x += 20) {
      for (double y = 0; y < size.height; y += 25) {
        if ((x + y * 0.1) % 60 < 30) {
          final height = (x * y * 0.01) % 30 + 10;
          canvas.drawLine(
            Offset(x, y),
            Offset(x, y + height),
            paint..color = baseColor.withOpacity(0.3 * ((x + y) % 3 * 0.3)),
          );
        }
      }
    }

    // Draw mathematical grid with sine wave patterns
    for (double x = 0; x < size.width; x += 40) {
      final waveOffset =
          (DateTime.now().millisecondsSinceEpoch * 0.01 + x * 0.1) % 100;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint
          ..color = baseColor.withOpacity(0.05 + sin(waveOffset * 0.1) * 0.02),
      );
    }

    for (double y = 0; y < size.height; y += 40) {
      final waveOffset =
          (DateTime.now().millisecondsSinceEpoch * 0.01 + y * 0.1) % 100;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint
          ..color = baseColor.withOpacity(0.05 + cos(waveOffset * 0.1) * 0.02),
      );
    }

    // Draw mathematical patterns (circles and arcs)
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final maxRadius = size.width * 0.8;

    for (double r = 50; r < maxRadius; r += 80) {
      final progress =
          (DateTime.now().millisecondsSinceEpoch * 0.001 + r * 0.01) % 1.0;
      final angle = progress * 3.14159 * 2;

      canvas.drawArc(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: r),
        angle,
        1.0,
        false,
        paint..color = baseColor.withOpacity(0.1 * sin(progress * 3.14159)),
      );
    }

    // Draw binary code patterns
    final rng = _SeededRandom(42);
    for (int i = 0; i < 100; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height;
      final binary = rng.nextDouble() > 0.5 ? '1' : '0';

      // Simulate text drawing with lines
      canvas.drawLine(
        Offset(x, y),
        Offset(x + 8, y),
        paint..color = baseColor.withOpacity(0.2),
      );
    }

    // Draw quantum wave patterns
    for (double x = 0; x < size.width; x += 5) {
      final time = DateTime.now().millisecondsSinceEpoch * 0.001;
      final wave1 = sin(x * 0.01 + time) * 20;
      final wave2 = cos(x * 0.015 + time * 1.3) * 15;

      canvas.drawLine(
        Offset(x, centerY + wave1),
        Offset(x, centerY + wave2),
        paint..color = baseColor.withOpacity(0.1),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Simple seeded random for consistent patterns
class _SeededRandom {
  int _seed;

  _SeededRandom(this._seed);

  double nextDouble() {
    _seed = (_seed * 1103515245 + 12345) & 0x7fffffff;
    return (_seed >> 16) / 32767.0;
  }
}

// Add these imports at the top if not already present

// Helper functions for math operations
double sin(double x) => math.sin(x);
double cos(double x) => math.cos(x);
