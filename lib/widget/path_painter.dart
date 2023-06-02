import 'package:flutter/material.dart';

class PathPainter extends CustomPainter {
  PathPainter({
    required this.path,
    required this.pathColor,
    required this.pathWidth,
  }) : pathPaint = Paint()
          ..color = pathColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = pathWidth;

  final Path path;
  final Color pathColor;
  final double pathWidth;
  Paint pathPaint;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(path, pathPaint);
  }

  @override
  bool shouldRepaint(covariant PathPainter oldDelegate) {
    return path != oldDelegate.path || pathColor != oldDelegate.pathColor;
  }
}
