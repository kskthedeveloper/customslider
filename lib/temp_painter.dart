import 'package:flutter/material.dart';
import 'dart:math';

class TempPainter extends CustomPainter {
  final double silderPosition;
  final double dragPercentage;
  final Color color;
  final Paint linePainter;

  TempPainter(
      {@required this.silderPosition,
      @required this.dragPercentage,
      @required this.color})
      : linePainter = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5;

  @override
  void paint(Canvas canvas, Size size) {
//    _paintLine(canvas, size);
//    _paintBlock(canvas, size);
    _paintController(canvas, size);
    _paintWaveLine(canvas, size);
    _textPainter(canvas, size);
    _paintMarks(canvas, size);
    _paintNumbers(canvas, size);
  }


  _paintMarks(Canvas canvas, Size size) {
    for (int i = 0; i <= 100; i++) {
      double position = (size.height / 100) * i;

      if(i % 10 == 0 || i == 0) {
        _paintSingleMark2(canvas, position, 10.0);
      } else {
        _paintSingleMark2(canvas, position, 0.0);
      }

    }
  }

  _paintNumbers(Canvas canvas, Size size) {
    var diff = (size.height / 100) * 10;
    for (int i = 0; i <= 100; i++) {
      double position = (size.height / 100) * i;
      if(i % 10 == 0 || i == 0) {
        _paintNumber(canvas, diff, position, i);
      }
    }
  }

  _paintSingleMark(Canvas canvas, double position, double dec, double slope) {
    Rect slider = Offset(40.0 - slope, position) & Size(20.0 + dec, .5);
    canvas.drawRect(slider, linePainter);
  }

  _paintSingleMark2(Canvas canvas, double position, double dec) {
    var nearDistance = 50;
    var liftDistance = 30;

    var diff = (silderPosition - position).abs();
    var distX = (diff/nearDistance) - 1;

    var moveX = min(distX * liftDistance, 0);

    Rect slider = Offset(30.0 - dec + moveX, position) & Size(10.0 + dec, .3);
    canvas.drawRect(slider, linePainter);
  }

  _paintNumber(Canvas canvas, double differ, double position, int index) {
    var nearDistance = 50;
    var liftDistance = 30;

    var differentBtuPoints = differ;

    var currentPoint = position;
    var previousPoint = currentPoint - differentBtuPoints;
    var nextPoint = currentPoint + differentBtuPoints;

    var newPoint = 0;

    if(silderPosition > currentPoint && silderPosition < nextPoint ) {
      var newCurrentPoint = (currentPoint - silderPosition).abs().round();
      newPoint = ((newCurrentPoint * 9)/differ.round()).round();
      index += newPoint;
    }

    var diff = (silderPosition - position).abs();
    var distX = (diff/nearDistance) - 1 ;


    var moveX = min(distX * liftDistance, 0);

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 30 + newPoint.toDouble(),
    );
    final textSpan = TextSpan(
      text:  '$index %',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: 100.0,
    );


    var offset = Offset(-100, position - 20 + (newPoint * 5));

    var myPoint = moveX.abs().round();

    textPainter.paint(canvas, offset);
  }

  _paintWaveLine(Canvas canvas, Size size) {
    double bendWidth = 70.0;
    double bezierWidth = 50.0;

    double startOfBend = silderPosition - bendWidth / 2;
    double startOfBezier = startOfBend - bezierWidth;
    double endOfBend = silderPosition + bendWidth / 2;
    double endOfBezier = endOfBend + bezierWidth;

    double controlHeight = size.width / 2.4;
    double centerPoint = silderPosition;

    double upperControlPoint1 = startOfBend;
    double upperControlPoint2 = startOfBend;
    double lowerControlPoint1 = endOfBend;
    double lowerControlPoint2 = endOfBend;

    Path path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, startOfBezier);
    path.cubicTo(size.width, upperControlPoint1, controlHeight,
        upperControlPoint2, controlHeight, centerPoint);
    path.cubicTo(controlHeight, lowerControlPoint1, size.width,
        lowerControlPoint2, size.width, endOfBezier);
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, linePainter);
  }

  _paintLine(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(0.0, size.height);
    canvas.drawPath(path, linePainter);
  }

  _paintBlock(Canvas canvas, Size size) {
    Rect slider = Offset(-5.0, silderPosition) & Size(20.0, 2.0);
    canvas.drawRect(slider, linePainter);
  }

  _paintController(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(size.width, silderPosition), 20.0, linePainter);
  }

  _textPainter(Canvas canvas, Size size) {
    final icon = Icons.swap_vert;
    TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
    textPainter.text = TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
            fontSize: 40.0, fontFamily: icon.fontFamily, color: Colors.blue));
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width - 20, silderPosition - 20));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
