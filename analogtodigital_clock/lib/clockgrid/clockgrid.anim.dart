// Copyright 2020 rt-apps. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:analogtodigital_clock/clockface/clockface.model.dart';

/// Clock grid animation model
class ClockGridAnim {
  ClockGridAnim({
    @required this.time,
    @required this.duration,
    @required this.isAnimPattern,
    @required this.isFontItems,
    this.faceFontColor,
    this.handFontColor,
    this.faceBlankColor,
    this.handBlankColor
  });

  ClockGridAnimTime time;
  int duration;
  bool isAnimPattern;
  bool isFontItems; 
  ClockGridAnimColor faceFontColor;
  ClockGridAnimColor handFontColor;
  ClockGridAnimColor faceBlankColor;
  ClockGridAnimColor handBlankColor;
}

class ClockGridAnimTime {
  ClockGridAnimTime(
    this.begin,
    this.end,
  );

  ClockTime begin;
  ClockTime end;
}

class ClockGridTheme {
  ClockGridTheme({
    @required this.face,
    @required this.hand,
    @required this.shadow,
  });

  Color face;
  Color hand;
  Color shadow;
}

class ClockGridAnimColor {
  ClockGridAnimColor(
    this.begin,
    this.end,
  );

  Color begin;
  Color end;
}
