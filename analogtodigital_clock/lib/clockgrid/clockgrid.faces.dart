// Copyright 2020 rt-apps. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:analogtodigital_clock/clockfont/clockfont.dart';
import 'package:analogtodigital_clock/clockface/clockface.model.dart';
import 'clockgrid.anim.dart';
import 'clockgrid.model.dart';

/// Maintains the grid of clock face values
class ClockGridFaces {
  ClockGridFaces({@required this.rows, @required this.columns}) {
    _init();
  }

  int rows;
  int columns;
  List<List<ClockFaceModel>> list;

  /// Initialise list
  void _init() {
    list = new List<List<ClockFaceModel>>();
    for (int rowIndex = 0; rowIndex < rows; rowIndex++) {
      List<ClockFaceModel> rowList = new List<ClockFaceModel>();
      for (int index = 0; index < columns; index++) {
        rowList.add(ClockFaceModel());
      }
      list.add(rowList);
    }
  }

  /// Update clock face list
  void update(List<ClockGridFontItem> fontItems, ClockGridAnim animation) {
    for (int rowIndex = 0; rowIndex < rows; rowIndex++) {
      for (int columnIndex = 0; columnIndex < columns; columnIndex++) {
        ClockFaceModel clockFace = list[rowIndex][columnIndex];

        // time begin
        clockFace.begin = animation.time.begin == null ? clockFace.end : animation.time.begin;

        // time end
        ClockTime fontItemTime = _getFontItemEndTime(rowIndex, columnIndex, fontItems);
        bool isFontItem = animation.isFontItems && fontItemTime != null && !ClockFont.isBlankTime(fontItemTime);
        clockFace.end = isFontItem ? fontItemTime : _getBlankEndTime(rowIndex, columnIndex, animation.time.end, animation.isAnimPattern);

        // face color
        ClockGridAnimColor faceColor = isFontItem ? animation.faceFontColor : animation.faceBlankColor;
        clockFace.faceBegin = faceColor.begin == null ? clockFace.faceEnd : faceColor.begin;
        clockFace.faceEnd = faceColor.end;

        // hand color
        ClockGridAnimColor handColor = isFontItem ? animation.handFontColor : animation.handBlankColor;
        clockFace.handBegin = handColor.begin == null ? clockFace.handEnd : handColor.begin;
        clockFace.handEnd = handColor.end;
      }
    }
  }

  /// Get item clock end time
  ClockTime _getFontItemEndTime(int rowIndex, int columnIndex, List<ClockGridFontItem> items) {
    ClockTime time;
    for (int index = 0; index < items.length; index++) {
      var item = items[index];
      time = _getFontItemTime(rowIndex, columnIndex, item.row, item.column, item);
      if (time != null) {
        break;
      }
    }
    return time;
  }

  /// Get blank clock end time
  ClockTime _getBlankEndTime(int rowIndex, int columnIndex, ClockTime end, bool isOffset) {
    if (isOffset) {
      int hour = end.hour + rowIndex - columnIndex;
      int minute = end.minute + rowIndex - columnIndex;
      return ClockTime(hour, minute);
    }
    return end;
  }

  /// Get clock font time
  ClockTime _getFontItemTime(int rowIndex, int columnIndex, int row, int column, ClockGridFontItem fontItem) {
    int width = ClockFont.getWidth(fontItem.size);
    int height = ClockFont.getHeight(fontItem.size);
    bool isColumnIntersect = columnIndex >= column && columnIndex < column + width;
    bool isRowIntersect = rowIndex >= row && rowIndex < row + height;

    if (isColumnIntersect && isRowIntersect) {
      int fontIndex = ((rowIndex - row) * (width * 2)) + ((columnIndex - column) * 2);
      return ClockFont.getClockTime(fontItem.value, fontIndex, fontItem.size);
    }
    return null;
  }
}
