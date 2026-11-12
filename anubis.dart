import 'package:flutter/material.dart';

import '../theme.dart';

/// رأس أنوبيس (إله التحنيط برأس ابن آوى) مرسوم بالكود على شبكة 100×100.
/// نفس الرسم موجود في tool/anubis.svg الذي صُنعت منه أيقونة التطبيق.
class AnubisPainter extends CustomPainter {
  const AnubisPainter();

  static const _black = Color(0xFF101018);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.shortestSide / 100;
    canvas.save();
    canvas.scale(s);

    Paint fill(Color c) => Paint()..color = c;
    Paint line(Color c, double w) => Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = w
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = c;

    // القلادة (أربع حلقات)
    const collar = [
      [8.0, 42.0, Pal.gold],
      [18.0, 32.0, Pal.turquoise],
      [26.0, 24.0, Pal.carnelian],
      [33.0, 17.0, Pal.goldLight],
    ];
    for (final c in collar) {
      final left = c[0] as double;
      final r = c[1] as double;
      final color = c[2] as Color;
      final p = Path()
        ..moveTo(left, 100)
        ..arcToPoint(Offset(100 - left, 100), radius: Radius.circular(r))
        ..close();
      canvas.drawPath(p, fill(color));
      canvas.drawPath(p, line(Pal.ink, 1));
    }

    // الرأس بالأذنين
    final head = Path()
      ..moveTo(30, 5)
      ..lineTo(40, 30)
      ..quadraticBezierTo(50, 26, 60, 30)
      ..lineTo(70, 5)
      ..lineTo(76, 40)
      ..quadraticBezierTo(76, 53, 66, 59)
      ..lineTo(58, 90)
      ..lineTo(42, 90)
      ..lineTo(34, 59)
      ..quadraticBezierTo(24, 53, 24, 40)
      ..close();
    canvas.drawPath(head, fill(_black));
    canvas.drawPath(head, line(Pal.gold, 1.6));

    canvas.drawPath(
      Path()
        ..moveTo(31, 14)
        ..lineTo(37, 32)
        ..lineTo(33, 38)
        ..close(),
      fill(Pal.gold),
    );
    canvas.drawPath(
      Path()
        ..moveTo(69, 14)
        ..lineTo(63, 32)
        ..lineTo(67, 38)
        ..close(),
      fill(Pal.gold),
    );

    // الخطم
    canvas.drawPath(
      Path()
        ..moveTo(43, 56)
        ..lineTo(57, 56)
        ..lineTo(55.5, 84)
        ..lineTo(44.5, 84)
        ..close(),
      fill(const Color(0xFF2B2B3A)),
    );
    canvas.drawLine(const Offset(50, 56), const Offset(50, 82), line(Pal.gold.withOpacity(0.7), 0.8));
    final nose = Rect.fromCenter(center: const Offset(50, 86), width: 14, height: 8);
    canvas.drawOval(nose, fill(const Color(0xFF050508)));
    canvas.drawOval(nose, line(Pal.gold, 1));

    // العينان بالكُحل والحاجبين
    for (final m in const [1.0, -1.0]) {
      double x(double v) => 50 + (v - 50) * m;
      final eye = Path()
        ..moveTo(x(31), 46)
        ..quadraticBezierTo(x(38), 40, x(45), 46)
        ..quadraticBezierTo(x(38), 51, x(31), 46)
        ..close();
      canvas.drawPath(eye, fill(Pal.goldLight));
      canvas.drawPath(eye, line(Pal.gold, 1));
      canvas.drawCircle(Offset(x(38), 46), 2.2, fill(const Color(0xFF050508)));
      canvas.drawLine(Offset(x(31), 46), Offset(x(24), 49), line(Pal.gold, 1.2));
      final brow = Path()
        ..moveTo(x(30), 41)
        ..quadraticBezierTo(x(38), 36, x(46), 41);
      canvas.drawPath(brow, line(Pal.gold, 1.2));
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
