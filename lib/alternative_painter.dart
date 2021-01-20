import 'package:flutter/material.dart';

class OpenPainter extends CustomPainter with ChangeNotifier {
  final int maxIndex;
  int currentIndex = 1;

  void changeIndex(int index) {
    currentIndex = index + 1;
    notifyListeners();
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    var radius = 3.0;
    var gap = radius * 1.75;
    var barHeight = radius * 2;
    var barWidth = radius * 7;

    var distance = 0.0;
    var barRadius = radius * 2;

    for (int i = 1; i <= maxIndex; i++) {
      var width = i == currentIndex ? barWidth : radius * 2;
      var height = i == currentIndex ? barHeight : radius * 2;

      // simple calculation to center the canvas
      if (i == 1) {
        var fullLength =
            (maxIndex - 1) * gap + (maxIndex - 1) * barRadius + barWidth;
        canvas.translate((size.width / 2) - fullLength / 2, 0);
      }

      canvas.drawRRect(
          RRect.fromRectAndCorners(
              Rect.fromLTRB(
                  distance, -(height / 2), distance + (width), barHeight / 2),
              bottomLeft: Radius.circular(barRadius),
              bottomRight: Radius.circular(barRadius),
              topLeft: Radius.circular(barRadius),
              topRight: Radius.circular(barRadius)),
          paint1);

      distance += width + gap;
    }
  }

  OpenPainter(this.maxIndex, this.currentIndex);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
