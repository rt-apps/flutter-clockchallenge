// Copyright 2020 rt-apps. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Clock hour and minute hands drawn with customer painter
class ClockHand extends StatelessWidget {
  const ClockHand({
    @required this.angleRadians,
    @required this.color,
  });

  final double angleRadians;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _ClockHandPainter(
            angleRadians: angleRadians,
            color: color,
          ),
        ),
      ),
    );
  }
}

class _ClockHandPainter extends CustomPainter {
  _ClockHandPainter({
    @required this.angleRadians,
    @required this.color,
  });

  double angleRadians;
  Color color;

  final double handLength = 0.85;
  final double handThickness = 9;

  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;
    final angle = angleRadians - math.pi / 2.0;
    final length = size.shortestSide * 0.5 * handLength;
    final position = center + Offset(math.cos(angle), math.sin(angle)) * length;
    final linePaint = Paint()
      ..color = color
      ..strokeWidth = handThickness
      ..strokeCap = StrokeCap.square;

    canvas.drawLine(center, position, linePaint);
  }

  @override
  bool shouldRepaint(_ClockHandPainter oldDelegate) {
    return oldDelegate.angleRadians != angleRadians || oldDelegate.color != color;
  }
}
