import 'package:flutter/material.dart';

/// Creates a realistic ticket shape with semi-circular notches on both sides.
///
/// The [notchRadius] controls the size of the notch cutout.
/// The [notchPosition] is a value between 0.0 and 1.0 representing
/// how far down the card the notch should be placed (default 0.55).
class TicketClipper extends CustomClipper<Path> {
  final double notchRadius;
  final double notchPosition;

  TicketClipper({this.notchRadius = 20, this.notchPosition = 0.55});

  @override
  Path getClip(Size size) {
    final path = Path();
    final notchY = size.height * notchPosition;

    // Start at top-left with rounded corner
    path.moveTo(16, 0);
    path.lineTo(size.width - 16, 0);
    // Top-right rounded corner
    path.quadraticBezierTo(size.width, 0, size.width, 16);

    // Right edge down to notch
    path.lineTo(size.width, notchY - notchRadius);
    // Right notch (semi-circle inward)
    path.arcToPoint(
      Offset(size.width, notchY + notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    // Right edge down to bottom
    path.lineTo(size.width, size.height - 16);
    // Bottom-right rounded corner
    path.quadraticBezierTo(size.width, size.height, size.width - 16, size.height);

    // Bottom edge
    path.lineTo(16, size.height);
    // Bottom-left rounded corner
    path.quadraticBezierTo(0, size.height, 0, size.height - 16);

    // Left edge up to notch
    path.lineTo(0, notchY + notchRadius);
    // Left notch (semi-circle inward)
    path.arcToPoint(
      Offset(0, notchY - notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    // Left edge up to top
    path.lineTo(0, 16);
    // Top-left rounded corner
    path.quadraticBezierTo(0, 0, 16, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TicketClipper oldClipper) =>
      notchRadius != oldClipper.notchRadius ||
      notchPosition != oldClipper.notchPosition;
}
