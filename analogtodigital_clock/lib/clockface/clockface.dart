// Copyright 2020 rt-apps. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

import 'clockface.model.dart';
import 'clockhand.dart';

final radiansPerSecond = radians(360 / 60);
final radiansPerHour = radians(360 / 12);

/// A clock face with hour, minute, face color and hand color tween animations
class ClockFace extends StatelessWidget {
  ClockFace({
    Key key,
    @required this.controller,
    @required this.model,
  })  : _hourAnimation = Tween<double>(
          begin: model.begin.hour.toDouble(),
          end: model.end.hour.toDouble(),
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        )),
        _minuteAnimation = Tween<double>(
          begin: model.begin.minute.toDouble(),
          end: model.end.minute.toDouble(),
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        )),
        _faceAnimation = ColorTween(
          begin: model.faceBegin,
          end: model.faceEnd,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        )),
        _handAnimation = ColorTween(
          begin: model.handBegin,
          end: model.handEnd,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        )),
        super(key: key);

  final AnimationController controller;
  final ClockFaceModel model;
  final Animation<double> _hourAnimation;
  final Animation<double> _minuteAnimation;
  final Animation<Color> _faceAnimation;
  final Animation<Color> _handAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      width: 100,
      height: 100,
      decoration: new BoxDecoration(
        color: _faceAnimation?.value,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: model.shadow,
            blurRadius: 0.0,
            spreadRadius: 0.5,
            offset: const Offset(
              0.0,
              0.5,
            ),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClockHand(
            angleRadians: _minuteAnimation.value * radiansPerSecond,
            color: _handAnimation?.value,
          ),
          ClockHand(
            angleRadians: _hourAnimation.value * radiansPerHour,
            color: _handAnimation?.value,
          ),
        ],
      ),
    );
  }
}
