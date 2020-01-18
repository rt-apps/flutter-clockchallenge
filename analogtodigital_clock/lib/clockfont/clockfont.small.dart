// Copyright 2020 rt-apps. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Small clock font 
class ClockFontSmall {
  static final int width = 2;
  static final int height = 3;

  /// Array of two by three digits - sequence of hour and minute pairs
  static final List<List<int>> font = [
    // 0
    [15, 30, 21, 30, 0, 30, 0, 30, 15, 0, 21, 0],
    // 1
    [7, 35, 18, 30, 7, 35, 12, 30, 7, 35, 12, 0],
    // 2
    [15, 15, 21, 30, 15, 30, 21, 0, 15, 0, 21, 45],
    // 3
    [15, 15, 21, 30, 15, 15, 21, 0, 15, 15, 21, 0],
    // 4
    [18, 30, 18, 30, 15, 0, 12, 30, 7, 35, 12, 0],
    // 5
    [15, 30, 21, 45, 15, 0, 21, 30, 15, 15, 21, 0],
    // 6
    [15, 30, 21, 45, 12, 30, 21, 30, 15, 0, 21, 0],
    // 7
    [15, 15, 21, 30, 7, 35, 12, 30, 7, 35, 12, 0],
    // 8
    [15, 30, 21, 30, 15, 0, 21, 0, 15, 0, 21, 0],
    // 9
    [15, 30, 21, 30, 15, 0, 12, 30, 15, 15, 21, 0],
    // C (10)
    [3, 30, 9, 45, 12, 30, 7, 35, 3, 0, 9, 45],
    // F (11)
    [3, 30, 9, 45, 12, 30, 9, 45, 12, 0, 7, 35],
  ];
}
