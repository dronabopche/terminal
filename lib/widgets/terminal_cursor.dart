import 'package:flutter/material.dart';

class TerminalCursor extends StatefulWidget {
  final Color color;
  final bool isVisible;

  const TerminalCursor({
    super.key,
    required this.color,
    required this.isVisible,
  });

  @override
  State<TerminalCursor> createState() => _TerminalCursorState();
}

class _TerminalCursorState extends State<TerminalCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
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
        return Container(
          width: 8,
          height: 18,
          color: widget.isVisible
              ? widget.color.withOpacity(_controller.value)
              : Colors.transparent,
        );
      },
    );
  }
}
