import 'package:flutter/material.dart';

/// A horizontal dashed/dotted line separator.
///
/// Used inside ticket cards to mimic the tear-off perforated line
/// you'd find on a real paper ticket.
class DashedLine extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;
  final double dashGap;

  const DashedLine({
    super.key,
    this.height = 1,
    this.color = const Color(0xFFDDDDDD),
    this.dashWidth = 6,
    this.dashGap = 4,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, height),
      painter: _DashedLinePainter(
        color: color,
        dashWidth: dashWidth,
        dashGap: dashGap,
        strokeWidth: height,
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashGap;
  final double strokeWidth;

  _DashedLinePainter({
    required this.color,
    required this.dashWidth,
    required this.dashGap,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double startX = 0;
    final y = size.height / 2;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, y),
        Offset(startX + dashWidth, y),
        paint,
      );
      startX += dashWidth + dashGap;
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter oldDelegate) =>
      color != oldDelegate.color ||
      dashWidth != oldDelegate.dashWidth ||
      dashGap != oldDelegate.dashGap;
}
