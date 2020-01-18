// Copyright 2020 rt-apps. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

import 'package:analogtodigital_clock/clockface/clockface.model.dart';
import 'package:analogtodigital_clock/clockfont/clockfont.dart';
import 'clockgrid.anim.dart';
import 'clockgrid.faces.dart';

/// Clock grid model
/// Defines: grid size in row and columns, font items to show digital values and animations
class ClockGridModel {
  ClockGridModel({
    @required this.rows,
    @required this.columns,
    @required this.theme,
    @required this.fontItems,
    @required this.startAnimation,
    @required this.sequenceAnimation,
    @required this.isAnimateToEndOfMinute,
  }) {
    _clockFaces = ClockGridFaces(rows: rows, columns: columns);
  }

  int rows;
  int columns;
  ClockGridTheme theme;
  List<ClockGridFontItem> fontItems;
  ClockGridAnim startAnimation;
  List<ClockGridAnim> sequenceAnimation;
  bool isAnimateToEndOfMinute;

  int _sequenceIndex = 0;
  ClockGridFaces _clockFaces;
  bool _isStart = true;

  /// Update clock grid layout - init next animation
  Duration update() {
    ClockGridAnim animation;

    if (_isStart) {
      // initial start animation
      _isStart = false;
      animation = startAnimation;
    } else {
      // next sequence animation - repeat sequence
      _sequenceIndex = _sequenceIndex >= sequenceAnimation.length ? 0 : _sequenceIndex;
      animation = sequenceAnimation[_sequenceIndex];
      _sequenceIndex++;
    }

    // update themes - could moify to tween face and hand colors
    animation.faceFontColor = ClockGridAnimColor(theme.face, theme.face);
    animation.handFontColor = ClockGridAnimColor(theme.hand, theme.hand);
    animation.faceBlankColor = ClockGridAnimColor(theme.face, theme.face);
    animation.handBlankColor = ClockGridAnimColor(theme.hand, theme.hand);

    // update begin and end parameters for clock faces
    _clockFaces.update(fontItems, animation);

    // return animation duration - check if required to complete at end of minute
    int duration = animation.duration;
    if (isAnimateToEndOfMinute) {
      int remaining = (60 - DateTime.now().second) * 1000;
      duration = duration < remaining ? duration : remaining;
    }
    return Duration(milliseconds: duration);
  }

  /// Get clock face
  ClockFaceModel getClockFace(int rowIndex, int columnIndex) {
    return _clockFaces.list[rowIndex][columnIndex];
  }
}

class ClockGridFontItem {
  ClockGridFontItem({
    @required this.row,
    @required this.column,
    @required this.size,
    this.value,
  });

  int row;
  int column;
  ClockFontSize size;
  int value;
}
