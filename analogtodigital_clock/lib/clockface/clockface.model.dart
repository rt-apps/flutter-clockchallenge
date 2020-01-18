// Copyright 2020 rt-apps. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

/// Clock face model defining tween begin and end times, face color and hand color values
class ClockFaceModel {
  ClockFaceModel({
    this.begin,
    this.end,
    this.faceBegin,
    this.faceEnd,
    this.handBegin,
    this.handEnd,
    this.shadow,
  });

  ClockTime begin;
  ClockTime end;
  Color faceBegin;
  Color faceEnd;
  Color handBegin;
  Color handEnd;
  Color shadow;
}

class ClockTime {
  ClockTime(this.hour, this.minute);

  int hour;
  int minute;
}
