import 'package:flutter/material.dart';
import 'dart:math';

import 'package:quantum_terminal/pages/theme_manager.dart';

class NeonCyberTheme implements TerminalTheme {
  @override
  String get name => "NEON CYBER";
  @override
  String get fontFamily => "Source Code Pro";
  @override
  Color get backgroundColor => const Color(0xFF1A1B26);
  @override
  Color get textColor => const Color(0xFFFF2A6D);
  @override
  Color get accentColor => const Color(0xFF05D9FF);
  @override
  Color get cursorColor => const Color(0xFFFF2A6D);
  @override
  Color get promptColor => const Color(0xFFFF2A6D);
  @override
  Color get errorColor => const Color(0xFFFF44CC);
  @override
  Color get warningColor => const Color(0xFFFFE500);
  @override
  Color get successColor => const Color(0xFF00FF9F);

  @override
  List<Shadow> get textShadows => [
        Shadow(color: const Color(0xFFFF2A6D).withOpacity(0.7), blurRadius: 12),
        Shadow(
          color: const Color(0xFF05D9FF).withOpacity(0.5),
          blurRadius: 8,
          offset: const Offset(2, 2),
        ),
        Shadow(color: const Color(0xFFFF2A6D).withOpacity(0.3), blurRadius: 20),
      ];

  @override
  String get asciiArt => r'''
  ╔══════════════════════════════════════════════════╗
  ║  _   _ ______ _____   ____  _   _ ______ _____   ║
  ║ | \ | |  ____|  __ \ / __ \| \ | |  ____|  __ \  ║
  ║ |  \| | |__  | |__) | |  | |  \| | |__  | |__) | ║
  ║ | . ` |  __| |  _  /| |  | | . ` |  __| |  _  /  ║
  ║ | |\  | |____| | \ \| |__| | |\  | |____| | \ \  ║
  ║ |_| \_|______|_|  \_\\____/|_| \_|______|_|  \_\ ║
  ╠══════════════════════════════════════════════════╣
  ║              QUANTUM TERMINAL v1.0               ║
  ║             NEON CYBER THEME ACTIVE              ║
  ║             CYBER SYSTEMS: ONLINE                ║
  ╚══════════════════════════════════════════════════╝
  ''';

  @override
  String get welcomeMessage => '''
🌀 WELCOME TO NEON CYBER TERMINAL

Cyber Systems: Online
Neural Network: Connected
Quantum Link: Established
Security: Quantum Encryption

Grid Status: Stable
Power: 98.7%
Firewall: Active

Type 'help' for cyber commands.
''';

  @override
  BoxDecoration get terminalDecoration => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFF1A1B26), const Color(0xFF2D3047)],
        ),
        border: Border.all(
          color: const Color(0xFFFF2A6D).withOpacity(0.6),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF2A6D).withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: const Color(0xFF05D9FF).withOpacity(0.2),
            blurRadius: 30,
            spreadRadius: 1,
          ),
        ],
      );

  // Math-generated cyber background
  @override
  Widget get backgroundWidget => CustomPaint(
        painter: _NeonCyberBackgroundPainter(accentColor, textColor),
        size: Size.infinite,
      );
}

class _NeonCyberBackgroundPainter extends CustomPainter {
  final Color neonPink;
  final Color neonBlue;

  _NeonCyberBackgroundPainter(this.neonBlue, this.neonPink);

  @override
  void paint(Canvas canvas, Size size) {
    final pinkPaint = Paint()
      ..color = neonPink
      ..strokeWidth = 1.0;

    final bluePaint = Paint()
      ..color = neonBlue
      ..strokeWidth = 1.0;

    final time = DateTime.now().millisecondsSinceEpoch * 0.001;

    // Draw cyber grid with animated glow
    for (double x = 0; x < size.width; x += 50) {
      final wave = sin(time + x * 0.01) * 0.5 + 0.5;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        pinkPaint..color = neonPink.withOpacity(0.1 * wave),
      );
    }

    for (double y = 0; y < size.height; y += 50) {
      final wave = cos(time + y * 0.01) * 0.5 + 0.5;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        bluePaint..color = neonBlue.withOpacity(0.1 * wave),
      );
    }

    // Draw neon circles
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final maxRadius = min(size.width, size.height) * 0.6;

    for (double r = 30; r < maxRadius; r += 60) {
      final progress = (time + r * 0.005) % 1.0;
      final opacity = 0.15 * sin(progress * pi);

      canvas.drawCircle(
        Offset(centerX, centerY),
        r,
        pinkPaint..color = neonPink.withOpacity(opacity),
      );

      canvas.drawCircle(
        Offset(centerX, centerY),
        r + 15,
        bluePaint..color = neonBlue.withOpacity(opacity * 0.7),
      );
    }

    // Draw cyber hexagons
    final hexSize = 40.0;
    for (double x = -hexSize; x < size.width + hexSize; x += hexSize * 1.5) {
      for (double y = -hexSize;
          y < size.height + hexSize;
          y += hexSize * 1.732) {
        _drawHexagon(canvas, Offset(x, y), hexSize, pinkPaint, bluePaint);
      }
    }

    // Draw data streams
    final rng = _SeededRandom(456);
    for (int i = 0; i < 80; i++) {
      final startX = rng.nextDouble() * size.width;
      final startY = rng.nextDouble() * size.height;
      final length = rng.nextDouble() * 100 + 50;
      final angle = rng.nextDouble() * pi * 2;
      final endX = startX + cos(angle) * length;
      final endY = startY + sin(angle) * length;

      final isPink = rng.nextDouble() > 0.5;
      final paint = isPink ? pinkPaint : bluePaint;

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        paint..color = (isPink ? neonPink : neonBlue).withOpacity(0.3),
      );
    }

    // Draw pulsing nodes
    for (int i = 0; i < 25; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height;
      final pulse = (sin(time * 2 + i) * 0.5 + 0.5);
      final radius = 2 + pulse * 3;

      final isPink = rng.nextDouble() > 0.5;
      final paint = isPink ? pinkPaint : bluePaint;

      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint..color = (isPink ? neonPink : neonBlue).withOpacity(0.6),
      );
    }
  }

  void _drawHexagon(Canvas canvas, Offset center, double size, Paint pinkPaint,
      Paint bluePaint) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = 2.0 * pi * i / 6;
      final x = center.dx + size * cos(angle);
      final y = center.dy + size * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(
      path,
      pinkPaint..color = neonPink.withOpacity(0.02),
    );

    canvas.drawPath(
      path,
      bluePaint
        ..color = neonBlue.withOpacity(0.01)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Seeded random class (same as in matrix_green.dart)
class _SeededRandom {
  int _seed;

  _SeededRandom(this._seed);

  double nextDouble() {
    _seed = (_seed * 1103515245 + 12345) & 0x7fffffff;
    return (_seed >> 16) / 32767.0;
  }
}
