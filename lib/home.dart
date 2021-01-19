import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter_onboarding/explanation.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';

final List<ExplanationData> data = [
  ExplanationData(
      description: "",
      title: "A Day at the Park",
      localImageSrc: "assets/1.svg",
      backgroundColor: Colors.orange[500]),
  ExplanationData(
      description: "",
      title: "Playing Fetch",
      localImageSrc: "assets/2.svg",
      backgroundColor: Colors.orange[700]),
  ExplanationData(
      description: "Relaxing Walk",
      title: "",
      localImageSrc: "assets/3.svg",
      backgroundColor: Colors.green[800]),
  ExplanationData(
      description: "Flutter",
      title: "",
      localImageSrc: "assets/4.svg",
      backgroundColor: Colors.green[300]),
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ChangeNotifier {
  final controller = PageController();

  int _currentIndex = 0;

  OpenPainter _painter = OpenPainter(3, 1);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: data[_currentIndex].backgroundColor,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: PageView(
                          scrollDirection: Axis.horizontal,
                          controller: controller,
                          onPageChanged: (value) {
                            _painter.changeIndex(value);
                            setState(() {
                              _currentIndex = value;
                            });
                            notifyListeners();
                          },
                          children: data
                              .map((e) => ExplanationPage(data: e))
                              .toList())),
                  flex: 5),
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(data.length,
                                (index) => createCircle(index: index)),
                          )),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _currentIndex == data.length - 1
                            ? []
                            : [
                                FlatButton(
                                  minWidth: 0.0,
                                  onPressed: () {
                                    /*...*/
                                  },
                                  child: Text(
                                    "Skip",
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                                Row(
                                  children: [
                                    FlatButton(
                                      padding: EdgeInsets.zero,
                                      minWidth: 0.0,
                                      onPressed: () {
                                        controller.nextPage(
                                            duration:
                                                Duration(milliseconds: 200),
                                            curve: Curves.easeInOut);
                                      },
                                      child: Text(
                                        "Next",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_right_alt_sharp,
                                      color: Theme.of(context).buttonColor,
                                    )
                                  ],
                                )
                              ],
                      )
                    ],
                  ))
            ],
          ),
        ],
      ),
    ));
  }

  createCircle({int index}) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 100),
        margin: EdgeInsets.only(right: 4),
        height: 5,
        width: _currentIndex == index ? 15 : 5,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(3)));
  }
}

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

  OpenPainter(this.maxIndex, this.currentIndex) {}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
