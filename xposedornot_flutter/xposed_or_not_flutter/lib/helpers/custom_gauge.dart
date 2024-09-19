import 'package:flutter/material.dart';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';

class CircularGaugePainter extends CustomPainter {
  final double value;
  final double maxValue;

  CircularGaugePainter(this.value, this.maxValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background Circle (Unfilled Part)
    final backgroundPaint = Paint()
      ..color = Colors.grey[700]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;

    canvas.drawCircle(center, radius - 20, backgroundPaint);

    // Filled Circle (Current Value)
    final filledPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.greenAccent, Colors.green],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    final sweepAngle = (value / maxValue) * 2 * pi;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 20),
      pi / 2,
      sweepAngle,
      false,
      filledPaint,
    );

    // Draw Current Value in the Center
    final textPainter = TextPainter(
      text: TextSpan(
        text: value.toStringAsFixed(0),
        style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontFamily: GoogleFonts.outfit().fontFamily),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      center - Offset(textPainter.width / 2, textPainter.height / 2 + 10),
    );

    // Unit of Measurement (Wh)
    final unitPainter = TextPainter(
      text: TextSpan(
        text: 'site(s)',
        style: TextStyle(
            color: Colors.grey[300],
            fontSize: 22,
            fontFamily: GoogleFonts.outfit().fontFamily),
      ),
      textDirection: TextDirection.ltr,
    );

    unitPainter.layout();
    unitPainter.paint(
      canvas,
      center + Offset(-30, textPainter.height / 2 - 8),
    );
  }

  @override
  bool shouldRepaint(CircularGaugePainter oldDelegate) {
    return oldDelegate.value != value || oldDelegate.maxValue != maxValue;
  }
}
