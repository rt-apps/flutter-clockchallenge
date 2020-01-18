// Copyright 2020 rt-apps. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';

import 'package:flutter_clock_helper/model.dart';
import 'analogtodigital.clockgrid.dart';

/// A clock made of a grid of analog clocks that animate to show a digital time and temperature
class AnalogToDigitalClock extends StatelessWidget {
  const AnalogToDigitalClock(this.model);

  final ClockModel model;

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.Hms().format(DateTime.now());

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Analog to digital clock with time $time',
        value: time,
      ),
      child: AnalogToDigitalClockGrid(
        is24HourFormat: model.is24HourFormat,
        temperature: model.temperature,
        temperatureUnit: model.unit,
        brightness: Theme.of(context).brightness,
      ),
    );
  }
}
