import 'package:flutter/material.dart';
import 'dart:math';

import 'package:quantum_terminal/pages/theme_manager.dart';

class QuantumBlueTheme implements TerminalTheme {
  @override
  String get name => "QUANTUM BLUE";
  @override
  String get fontFamily => "Fira Code";
  @override
  Color get backgroundColor => const Color(0xFF0A1128);
  @override
  Color get textColor => const Color(0xFF64FFDA);
  @override
  Color get accentColor => const Color(0xFF448AFF);
  @override
  Color get cursorColor => const Color(0xFF64FFDA);
  @override
  Color get promptColor => const Color(0xFF2979FF);
  @override
  Color get errorColor => const Color(0xFFFF5252);
  @override
  Color get warningColor => const Color(0xFFFFD740);
  @override
  Color get successColor => const Color(0xFF69F0AE);

  @override
  List<Shadow> get textShadows => [
        Shadow(color: const Color(0xFF64FFDA).withOpacity(0.6), blurRadius: 15),
        Shadow(
          color: const Color(0xFF448AFF).withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(2, 2),
        ),
      ];

  @override
  String get asciiArt => r'''
  ╔══════════════════════════════════════════════════╗
  ║   ___                  _        _                ║
  ║  / _ \ _   _  ___ _ __(_)_ __  (_) __ _ _   _    ║
  ║ | | | | | | |/ _ \ '__| | '_ \ | |/ _` | | | |   ║
  ║ | |_| | |_| |  __/ |  | | | | || | (_| | |_| |   ║
  ║  \__\_\\__,_|\___|_|  |_|_| |_|/ |\__,_|\__, |   ║
  ║                               |__/      |___/    ║
  ╠══════════════════════════════════════════════════╣
  ║              QUANTUM TERMINAL v1.0               ║
  ║            QUANTUM BLUE THEME ACTIVE             ║
  ║            QUANTUM STATE: COHERENT               ║
  ╚══════════════════════════════════════════════════╝
  ''';

  @override
  String get welcomeMessage => '''
🌌 WELCOME TO QUANTUM BLUE TERMINAL

Quantum Processor: Online
Qubits: 32 Active
Entanglement: Stable
Temperature: 15mK

Quantum State: |Ψ⟩ = α|0⟩ + β|1⟩
Superposition: Active
Decoherence: Minimal

Type 'help' for quantum commands.
''';

  @override
  BoxDecoration get terminalDecoration => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFF0A1128), const Color(0xFF1A237E)],
        ),
        border: Border.all(
          color: const Color(0xFF448AFF).withOpacity(0.4),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF448AFF).withOpacity(0.2),
            blurRadius: 25,
            spreadRadius: 3,
          ),
        ],
      );

  // Math-generated quantum background
  @override
  Widget get backgroundWidget => CustomPaint(
        painter: _QuantumBackgroundPainter(accentColor, textColor),
        size: Size.infinite,
      );
}

class _QuantumBackgroundPainter extends CustomPainter {
  final Color quantumBlue;
  final Color quantumTeal;

  _QuantumBackgroundPainter(this.quantumBlue, this.quantumTeal);

  @override
  void paint(Canvas canvas, Size size) {
    final bluePaint = Paint()
      ..color = quantumBlue
      ..strokeWidth = 1.0;

    final tealPaint = Paint()
      ..color = quantumTeal
      ..strokeWidth = 1.0;

    final time = DateTime.now().millisecondsSinceEpoch * 0.001;

    // Draw quantum wave interference patterns
    for (double x = 0; x < size.width; x += 4) {
      for (double y = 0; y < size.height; y += 4) {
        final wave1 = sin(x * 0.02 + time) * 0.5 + 0.5;
        final wave2 = cos(y * 0.02 + time * 1.3) * 0.5 + 0.5;
        final combined = (wave1 + wave2) * 0.5;

        if (combined > 0.7) {
          canvas.drawCircle(
            Offset(x, y),
            0.5,
            tealPaint..color = quantumTeal.withOpacity(0.3),
          );
        } else if (combined > 0.5) {
          canvas.drawCircle(
            Offset(x, y),
            0.3,
            bluePaint..color = quantumBlue.withOpacity(0.2),
          );
        }
      }
    }

    // Draw quantum orbits
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final maxRadius = min(size.width, size.height) * 0.8;

    for (double r = 40; r < maxRadius; r += 80) {
      final progress = (time * 0.5 + r * 0.001) % 1.0;
      final angle = progress * pi * 2;

      // Draw orbital paths
      canvas.drawCircle(
        Offset(centerX, centerY),
        r,
        bluePaint..color = quantumBlue.withOpacity(0.05),
      );

      // Draw orbiting particles
      final particleX = centerX + cos(angle) * r;
      final particleY = centerY + sin(angle) * r;

      canvas.drawCircle(
        Offset(particleX, particleY),
        3.0,
        tealPaint..color = quantumTeal.withOpacity(0.6),
      );
    }

    // Draw probability clouds
    final rng = _SeededRandom(789);
    for (int i = 0; i < 200; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height;
      final distance = sqrt(pow(x - centerX, 2) + pow(y - centerY, 2));
      final probability = exp(-distance / 200);

      if (rng.nextDouble() < probability * 0.5) {
        canvas.drawCircle(
          Offset(x, y),
          rng.nextDouble() * 2 + 0.5,
          tealPaint..color = quantumTeal.withOpacity(probability * 0.3),
        );
      }
    }

    // Draw quantum entanglement lines
    for (int i = 0; i < 30; i++) {
      final angle1 = rng.nextDouble() * pi * 2;
      final angle2 = angle1 + pi + (rng.nextDouble() - 0.5) * 0.5;
      final radius = rng.nextDouble() * maxRadius * 0.5 + 50;

      final x1 = centerX + cos(angle1) * radius;
      final y1 = centerY + sin(angle1) * radius;
      final x2 = centerX + cos(angle2) * radius;
      final y2 = centerY + sin(angle2) * radius;

      canvas.drawLine(
        Offset(x1, y1),
        Offset(x2, y2),
        bluePaint..color = quantumBlue.withOpacity(0.1),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Seeded random class
class _SeededRandom {
  int _seed;

  _SeededRandom(this._seed);

  double nextDouble() {
    _seed = (_seed * 1103515245 + 12345) & 0x7fffffff;
    return (_seed >> 16) / 32767.0;
  }
}
