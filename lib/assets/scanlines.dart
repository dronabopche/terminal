import 'dart:ui' as ui;
import 'dart:ui';

Future<ui.Image> generateScanlines() async {
  const width = 100;
  const height = 100;
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder);
  final paint = Paint()
    ..color = const Color(0xFF00FF41)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0.5;

  // Draw scanlines
  for (int y = 0; y < height; y += 2) {
    canvas.drawLine(
      Offset(0, y.toDouble()),
      Offset(width.toDouble(), y.toDouble()),
      paint,
    );
  }

  final picture = recorder.endRecording();
  return await picture.toImage(width, height);
}
