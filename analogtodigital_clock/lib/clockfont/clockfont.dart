// Copyright 2020 rt-apps. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:analogtodigital_clock/clockface/clockface.model.dart';
import 'clockfont.large.dart';
import 'clockfont.small.dart';

/// Retrieves clock font values
class ClockFont {
  static final ClockTime blankTime = ClockTime(7, 35);

  /// Get font value clocktime
  static ClockTime getClockTime(int value, int index, ClockFontSize size) {
    if (size == ClockFontSize.small) {
      return ClockTime(ClockFontSmall.font[value][index], ClockFontSmall.font[value][index + 1]);
    } else {
      return ClockTime(ClockFontLarge.font[value][index], ClockFontLarge.font[value][index + 1]);
    }
  }

  /// Get font width
  static int getWidth(ClockFontSize size) {
    return size == ClockFontSize.small ? ClockFontSmall.width : ClockFontLarge.width;   
  }

  /// Get font height
  static int getHeight(ClockFontSize size) {
    return size == ClockFontSize.small ? ClockFontSmall.height : ClockFontLarge.height;
  }

  /// Is blank time
  static bool isBlankTime(ClockTime time) {
    return time.hour == blankTime.hour && time.minute == blankTime.minute;
  }
}

enum ClockFontSize {
  small,
  large,
}
