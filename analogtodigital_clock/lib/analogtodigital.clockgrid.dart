// Copyright 2020 rt-apps. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_clock_helper/model.dart';
import 'clockface/clockface.model.dart';
import 'clockfont/clockfont.dart';
import 'clockgrid/clockgrid.dart';
import 'clockgrid/clockgrid.anim.dart';
import 'clockgrid/clockgrid.model.dart';

/// Uses ClockGrid widget to show time and temperature
class AnalogToDigitalClockGrid extends StatefulWidget {
  AnalogToDigitalClockGrid({
    @required this.is24HourFormat,
    @required this.temperature,
    @required this.temperatureUnit,
    @required this.brightness,
  });

  final bool is24HourFormat;
  final double temperature;
  final TemperatureUnit temperatureUnit;
  final Brightness brightness;

  @override
  _AnalogToDigitalClockGridState createState() => _AnalogToDigitalClockGridState();
}

class _AnalogToDigitalClockGridState extends State<AnalogToDigitalClockGrid> {
  ClockGridModel _model;
  bool isPlayNext;

  final ClockGridTheme _lightTheme = ClockGridTheme(
    face: Colors.white,
    hand: Colors.black,
    shadow: Colors.black,
  );
  final ClockGridTheme _darkTheme = ClockGridTheme(
    face: Color(0xff222342),
    hand: Color(0xffd0d0d0),
    shadow: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    _initModel();
  }

  @override
  void didUpdateWidget(AnalogToDigitalClockGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool isRestart = oldWidget.brightness != widget.brightness || oldWidget.is24HourFormat != widget.is24HourFormat || oldWidget.temperatureUnit != widget.temperatureUnit;

    if (isRestart) {
      _initModel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClockGrid(
      model: _model,
      isPlayNext: isPlayNext,
      onStart: () {
        isPlayNext = false;
      },
      onComplete: () {
        setState(() {
          _onUpdateModel();
        });
      },
    );
  }

  /// Update clock grid model items at end of each animation
  void _onUpdateModel() {
    DateTime now = DateTime.now();

    // update hour font item - large font
    final hour = int.parse(DateFormat(widget.is24HourFormat ? 'HH' : 'hh').format(now));
    _model.fontItems[0].value = (hour / 10).floor();
    _model.fontItems[1].value = hour % 10;

    // update minutes font item - large font
    _model.fontItems[2].value = (now.minute / 10).floor();
    _model.fontItems[3].value = now.minute % 10;

    // update temperature font item - small font
    double temperature = widget.temperature >= 100 ? 99 : widget.temperature;
    _model.fontItems[4].value = (temperature / 10).floor();
    _model.fontItems[5].value = (temperature % 10).ceil();
    _model.fontItems[6].value = widget.temperatureUnit == TemperatureUnit.celsius ? 10 : 11;

    // Play next animation
    isPlayNext = true;
  }

  /// Init clock grid model - defines font items and animations
  void _initModel() {
    ClockGridTheme theme = widget.brightness == Brightness.light ? _lightTheme : _darkTheme;

    _model = new ClockGridModel(
      rows: 12,
      columns: 21,
      theme: theme,
      fontItems: [
        // first hour digit
        ClockGridFontItem(
          row: 1,
          column: 2,
          size: ClockFontSize.large,
        ),
        // second hour digit
        ClockGridFontItem(
          row: 1,
          column: 6,
          size: ClockFontSize.large,
        ),
        // first minute digit
        ClockGridFontItem(
          row: 1,
          column: 11,
          size: ClockFontSize.large,
        ),
        // second minute digit
        ClockGridFontItem(
          row: 1,
          column: 15,
          size: ClockFontSize.large,
        ),
        // first temperature digit
        ClockGridFontItem(
          row: 8,
          column: 2,
          size: ClockFontSize.small,
        ),
        // second temperature digit
        ClockGridFontItem(
          row: 8,
          column: 4,
          size: ClockFontSize.small,
        ),
        // temperature type char
        ClockGridFontItem(
          row: 8,
          column: 6,
          size: ClockFontSize.small,
        ),
      ],
      startAnimation: ClockGridAnim(
        time: ClockGridAnimTime(ClockTime(0, 30), ClockTime(7, 35)),
        duration: 15000,
        isAnimPattern: false,
        isFontItems: true,
      ),
      sequenceAnimation: [
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(7, 35)),
          duration: 5000,
          isAnimPattern: false,
          isFontItems: true,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(11, 25)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: true,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(11, 25)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: false,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(13, 35)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: true,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(13, 35)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: true,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(9, 15)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: true,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(9, 15)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: false,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(12, 30)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: true,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(12, 30)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: true,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(14, 20)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: true,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(14, 20)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: false,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(10, 40)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: true,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(10, 40)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: true,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(7, 25)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: true,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(7, 25)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: false,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(11, 05)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: true,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(11, 05)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: true,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(15, 30)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: true,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(15, 30)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: false,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(18, 45)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: true,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(18, 45)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: true,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(21, 59)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: false,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(21, 59)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: true,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(0, 30)),
          duration: 15000,
          isAnimPattern: true,
          isFontItems: true,
        ),
        ClockGridAnim(
          time: ClockGridAnimTime(null, ClockTime(7, 35)),
          duration: 15000,
          isAnimPattern: false,
          isFontItems: true,
        ),
      ],
      isAnimateToEndOfMinute: true,
    );

    _onUpdateModel();
  }
}
