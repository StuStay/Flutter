import 'package:flutter/material.dart';

class RadialPainter extends CustomPainter {
  Color bgColor;
  Color lineColor1;
  Color lineColor2;
  double percent1;
  double percent2;
  double width;

  RadialPainter({
    required this.bgColor,
    required this.lineColor1,
    required this.lineColor2,
    required this.percent1,
    required this.percent2,
    required this.width,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint bgLine = Paint()
      ..color = bgColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Paint completedLine1 = Paint()
      ..color = lineColor1
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Paint completedLine2 = Paint()
      ..color = lineColor2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2;

    canvas.drawCircle(center, radius, bgLine);

    double sweepRadian1 = 2 * 3.14 * percent1;
    double sweepRadian2 = 2 * 3.14 * percent2;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -3.14 / 2, sweepRadian1, false, completedLine1);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -3.14 / 2 + sweepRadian1, sweepRadian2, false, completedLine2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}