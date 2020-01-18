// Copyright 2020 rt-apps. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:analogtodigital_clock/clockface/clockface.model.dart';
import 'package:analogtodigital_clock/clockface/clockface.dart';
import 'clockgrid.model.dart';

/// Animated grid of analog clock faces
/// Model defines animations and digital font values to show within grid
class ClockGrid extends StatefulWidget {
  ClockGrid({
    @required this.model,
    @required this.onStart,
    @required this.onComplete,
    @required this.isPlayNext,
  });

  final ClockGridModel model;
  final void Function() onStart;
  final void Function() onComplete;
  final bool isPlayNext;

  @override
  _ClockGridState createState() => _ClockGridState();
}

class _ClockGridState extends State<ClockGrid> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _initAnimController();
    _playNext();
  }

  @override
  void didUpdateWidget(ClockGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlayNext) {
      _playNext();
    }
  }

  /// Init anim controller - on animation completed raise event
  void _initAnimController() {
    _controller = AnimationController(
      vsync: this,
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete();
        }
      });
  }

  /// Play next animation - update grid and get duration - raise event
  void _playNext() {
    _controller.reset();
    _controller.duration = widget.model.update();
    _controller.forward();

    widget.onStart();
    debugPrint("animation: ${DateTime.now().toString()} duration:${_controller.duration.inSeconds}");
  }

  /// Build grid row of clock faces
  List<Widget> _buildRow(int rowIndex) {
    List<ClockFace> list = new List<ClockFace>();
    for (int columnIndex = 0; columnIndex < widget.model.columns; columnIndex++) {
      ClockFaceModel clockFace = widget.model.getClockFace(rowIndex, columnIndex);
      clockFace.shadow = widget.model.theme.shadow;
      list.add(ClockFace(
        controller: _controller.view,
        model: clockFace,
      ));
    }
    return list;
  }

  /// Build grid rows
  List<Widget> _buildRows() {
    List<Row> list = new List<Row>();
    for (int rowIndex = 0; rowIndex < widget.model.rows; rowIndex++) {
      list.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: this._buildRow(rowIndex),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.model.theme.face,
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: this._buildRows(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
