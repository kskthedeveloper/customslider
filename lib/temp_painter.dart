import 'package:flutter/material.dart';

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
//    _paintMarks(canvas, size);
  }

  _paintMarks(Canvas canvas, Size size) {
    double bendWidth = 70.0;
    double bezierWidth = 50.0;
//    if(position.round() == silderPosition.round())
    for (int i = 0; i <= 100; i++) {
      double position = (size.height / 100) * i;

      if (position <= silderPosition.round() + 60 &&
          position >= silderPosition.round() - 60) {
        _paintCurveMarks(canvas, position, 0.0);
      } else {
        _paintSingleMark(canvas, position, 0.0, 0.0);
      }

//      if(i % 5 == 0 || i == 0) {
//        _paintSingleMark(canvas, position, 10.0);
//      } else {
//        _paintSingleMark(canvas, position, 0.0);
//      }

    }
  }

  _paintSingleMark(Canvas canvas, double position, double dec, double slope) {
    Rect slider = Offset(40.0 - slope, position) & Size(20.0 + dec, .5);
    canvas.drawRect(slider, linePainter);
  }

  _paintCurveMarks(Canvas canvas, double position, double dec) {
    print('in curve ${position.round()}');
    print('in curve slide ${silderPosition.round()}');

    if(position.round() == silderPosition.round()) {
      _paintSingleMark(canvas, position, 15.0, 60);
    } else if (position.round() > silderPosition.round()) {
      if (position.round() > silderPosition.round() &&
          position.round() < silderPosition.round() + 50) {
        if (position.round() > silderPosition.round() &&
            position.round() < silderPosition.round() + 40) {
          if (position.round() > silderPosition.round() &&
              position.round() < silderPosition.round() + 30) {
            if (position.round() > silderPosition.round() &&
                position.round() < silderPosition.round() + 20) {
              if (position.round() > silderPosition.round() &&
                  position.round() < silderPosition.round() + 10) {
                _paintSingleMark(canvas, position, 15.0, 55);
              } else {
                _paintSingleMark(canvas, position, 15.0, 50);
              }
            } else {
              _paintSingleMark(canvas, position, 15.0, 40);
            }
          } else {
            _paintSingleMark(canvas, position, 15.0, 30);
          }
        } else {
          _paintSingleMark(canvas, position, 15.0, 20);
        }
      } else {
        _paintSingleMark(canvas, position, 10.0, 10);
      }
    } else {
      if (position.round() < silderPosition.round() &&
          position.round() > silderPosition.round() - 50) {
        if (position.round() < silderPosition.round() &&
            position.round() > silderPosition.round() - 40) {
          if (position.round() < silderPosition.round() &&
              position.round() > silderPosition.round() - 30) {
            if (position.round() < silderPosition.round() &&
                position.round() > silderPosition.round() - 20) {
              if (position.round() > silderPosition.round() &&
                  position.round() < silderPosition.round() - 10) {
                _paintSingleMark(canvas, position, 10.0, 55);
              } else {
                _paintSingleMark(canvas, position, 10.0, 50);
              }
            } else {
              _paintSingleMark(canvas, position, 10.0, 40);
            }
          } else {
            _paintSingleMark(canvas, position, 10.0, 30);
          }
        } else {
          _paintSingleMark(canvas, position, 10.0, 20);
        }
      } else {
        _paintSingleMark(canvas, position, 10.0, 10);
      }
    }
  }

  _paintWaveLine(Canvas canvas, Size size) {
    double bendWidth = 70.0;
    double bezierWidth = 50.0;
//
    double startOfBend = silderPosition - bendWidth / 2;
    double startOfBezier = startOfBend - bezierWidth;
    double endOfBend = silderPosition + bendWidth / 2;
    double endOfBezier = endOfBend + bezierWidth;
//
    double controlHeight = size.width / 2.4;
    double centerPoint = silderPosition;
//
    double upperControlPoint1 = startOfBend;
    double upperControlPoint2 = startOfBend;
    double lowerControlPoint1 = endOfBend;
    double lowerControlPoint2 = endOfBend;
//
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
