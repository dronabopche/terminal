import 'dart:math';

import 'package:flutter/material.dart';

class QuantumParticles extends StatefulWidget {
  final Color particleColor;

  const QuantumParticles({super.key, required this.particleColor});

  @override
  State<QuantumParticles> createState() => _QuantumParticlesState();
}

class _QuantumParticlesState extends State<QuantumParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Initialize particles
    for (int i = 0; i < 20; i++) {
      _particles.add(Particle());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        _updateParticles();
        return CustomPaint(
          painter: QuantumParticlesPainter(
            particles: _particles,
            color: widget.particleColor,
            time: _controller.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }

  void _updateParticles() {
    for (final particle in _particles) {
      particle.update();
    }
  }
}

class Particle {
  double x = 0, y = 0;
  double vx = 0, vy = 0;
  double size = 0;
  double life = 1.0;

  Particle() {
    reset();
  }

  void reset() {
    x = DateTime.now().millisecond % 1000 / 1000;
    y = DateTime.now().millisecond % 1000 / 1000;
    vx = (DateTime.now().millisecond % 100 - 50) / 1000;
    vy = (DateTime.now().millisecond % 100 - 50) / 1000;
    size = 1 + DateTime.now().millisecond % 3;
    life = 1.0;
  }

  void update() {
    x += vx;
    y += vy;
    life -= 0.005;

    if (life <= 0 || x < 0 || x > 1 || y < 0 || y > 1) {
      reset();
    }
  }
}

class QuantumParticlesPainter extends CustomPainter {
  final List<Particle> particles;
  final Color color;
  final double time;

  QuantumParticlesPainter({
    required this.particles,
    required this.color,
    required this.time,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    for (final particle in particles) {
      final x = particle.x * size.width;
      final y = particle.y * size.height;
      final radius = particle.size * particle.life;

      canvas.drawCircle(Offset(x, y), radius, paint);

      // Draw quantum trail
      if (particle.life < 0.8) {
        final trailPaint = Paint()
          ..color = color.withOpacity(0.1 * particle.life)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.5;

        canvas.drawCircle(Offset(x, y), radius * 2, trailPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant QuantumParticlesPainter oldDelegate) => true;
}

class MatrixRain extends StatefulWidget {
  final Color textColor;

  const MatrixRain({super.key, required this.textColor});

  @override
  State<MatrixRain> createState() => _MatrixRainState();
}

class _MatrixRainState extends State<MatrixRain>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: MatrixRainPainter(
            color: widget.textColor,
            time: DateTime.now().millisecondsSinceEpoch / 1000,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class MatrixRainPainter extends CustomPainter {
  final Color color;
  final double time;

  MatrixRainPainter({required this.color, required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    const columns = 50;
    final columnWidth = size.width / columns;

    final textStyle = TextStyle(
      color: color.withOpacity(0.7),
      fontSize: 14,
      fontFamily: 'JetBrains Mono',
    );

    final paragraphs = <String>[];

    for (int i = 0; i < columns; i++) {
      final x = i * columnWidth;
      final seed = (i * 12345 + time * 1000).toInt();
      final random = Random(seed);

      final length = 5 + random.nextInt(15);
      final chars = List.generate(length, (j) {
        final charCode = 0x30A0 + random.nextInt(96);
        return String.fromCharCode(charCode);
      }).join('');

      paragraphs.add(chars);
    }

    // Simple text drawing (for demo)
    final paint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < columns; i++) {
      final x = i * columnWidth;
      final y = (time * 100 + i * 10) % size.height;
      canvas.drawCircle(Offset(x, y), 1, paint);
    }
  }

  @override
  bool shouldRepaint(covariant MatrixRainPainter oldDelegate) => true;
}
