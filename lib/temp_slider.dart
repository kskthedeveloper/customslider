import 'package:flutter/material.dart';
import 'package:flutterappverticalslider/temp_painter.dart';

import 'marks.dart';

class TempSlider extends StatefulWidget {

  @override
  _TempSliderState createState() => _TempSliderState();
}

class _TempSliderState extends State<TempSlider> {
  double width = 70.0;
  double height = 0;

  double _dragPostion = 0;
  double _dragPercentage = 0;

  void _updateDragPosition(Offset val) {
    double newDragPosition = 0;

    if (val.dy <= 0) {
      newDragPosition = 0;
    } else if (val.dy >= height) {
      newDragPosition = height;
    } else {
      newDragPosition = val.dy;
    }

    setState(() {
      _dragPostion = newDragPosition;
      _dragPercentage = _dragPostion / height;
    });
  }

  void _onDragUpdate(BuildContext context, DragUpdateDetails details) {
    RenderBox renderBox = context.findRenderObject();
    Offset offset = renderBox.globalToLocal(details.globalPosition);
    _updateDragPosition(offset);
  }

  void _onDragStart(BuildContext context, DragStartDetails details) {
    RenderBox renderBox = context.findRenderObject();
    Offset offset = renderBox.globalToLocal(details.globalPosition);
    _updateDragPosition(offset);
  }

  void _onDragEnd(BuildContext context, DragEndDetails details) {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height / 1.05;

    return Container(
      child: GestureDetector(
        child: Container(
          width: width,
          height: height,
          child: CustomPaint(
            painter: TempPainter(
                color: Colors.black,
                dragPercentage: _dragPercentage,
                silderPosition: _dragPostion
            ),
          ),
        ),
        onVerticalDragUpdate: (DragUpdateDetails update) => _onDragUpdate(context, update),
        onVerticalDragStart: (DragStartDetails update) => _onDragStart(context, update),
        onVerticalDragEnd: (DragEndDetails update) => _onDragEnd(context, update),
      ),
    );
  }
}
