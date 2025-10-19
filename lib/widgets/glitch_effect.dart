import 'package:flutter/material.dart';

class GlitchEffect extends StatefulWidget {
  final Widget child;
  final Color glitchColor;
  final bool active;

  const GlitchEffect({
    super.key,
    required this.child,
    required this.glitchColor,
    this.active = false,
  });

  @override
  State<GlitchEffect> createState() => _GlitchEffectState();
}

class _GlitchEffectState extends State<GlitchEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    if (widget.active) {
      _startGlitch();
    }
  }

  void _startGlitch() {
    _controller.repeat(reverse: true, period: const Duration(milliseconds: 50));

    // Stop after random time
    Future.delayed(Duration(milliseconds: 100 + _random.nextInt(400)), () {
      if (mounted) {
        _controller.stop();
      }
    });
  }

  @override
  void didUpdateWidget(GlitchEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !oldWidget.active) {
      _startGlitch();
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
        final offsetX = _random.nextDouble() * 4 - 2;
        final offsetY = _random.nextDouble() * 4 - 2;

        return Stack(
          children: [
            // Main content
            Transform.translate(offset: Offset(0, 0), child: widget.child),

            // Red glitch layer
            if (_controller.value > 0.5)
              Transform.translate(
                offset: Offset(offsetX, offsetY),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    widget.glitchColor,
                    BlendMode.srcIn,
                  ),
                  child: widget.child,
                ),
              ),

            // Blue glitch layer
            if (_controller.value > 0.7)
              Transform.translate(
                offset: Offset(-offsetX, -offsetY),
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.blue,
                    BlendMode.srcIn,
                  ),
                  child: widget.child,
                ),
              ),
          ],
        );
      },
    );
  }
}

class Random {
  final int seed;

  Random([this.seed = 0]);

  int nextInt(int max) {
    return DateTime.now().millisecondsSinceEpoch % max;
  }

  double nextDouble() {
    return (DateTime.now().millisecondsSinceEpoch % 1000) / 1000;
  }
}
