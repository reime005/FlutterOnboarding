import 'dart:developer';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ChangeNotifier {
  final controller = PageController();

  OpenPainter _painter = OpenPainter(3, 1);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: Colors.orange[500],
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: controller,
                    onPageChanged: (value) {
                      _painter.changeIndex(value);
                      notifyListeners();
                    },
                    children: [
                      SvgPicture.asset("assets/1.svg",
                          height: MediaQuery.of(context).size.height * 0.4,
                          alignment: Alignment.center),
                      SvgPicture.asset("assets/1.svg",
                          height: MediaQuery.of(context).size.height * 0.4,
                          alignment: Alignment.center),
                      SvgPicture.asset("assets/1.svg",
                          height: MediaQuery.of(context).size.height * 0.4,
                          alignment: Alignment.center),
                    ],
                  )),
              flex: 1),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Walk your dog",
                            style: Theme.of(context).textTheme.headline1,
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 32, left: 16, right: 16, bottom: 16),
                              child: Text(
                                "Reprehenderit ea ut cupidatat proident. Mollit proident eiusmod ad ex cillum officia dolore amet. Cillum amet eiusmod occaecat non non consectetur laborum do. Cupidatat dolore enim officia mollit.",
                                style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.center,
                              )),
                        ],
                      )),
                      Container(
                          child: CustomPaint(
                        painter: _painter,
                      )),
                      Row(
                        children: [
                          // Padding(
                          //   padding:
                          //       EdgeInsets.only(top: 32, left: 16, right: 16),
                          // ),
                          FlatButton(
                            onPressed: () {
                              /*...*/
                            },
                            child: Text(
                              "Flat Button",
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              /*...*/
                            },
                            child: Text(
                              "Flat Button",
                            ),
                          )
                        ],
                      )
                    ],
                  )),
              flex: 1),
        ],
      ),
      // child: GestureDetector(
      //   behavior: HitTestBehavior.translucent,
      //   onTap: () {
      //     print("test");
      //     log("message");
      //     setState(() {
      //       _lights = true;
      //     });
      //   },
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Container(
      //         color: Colors.red,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: <Widget>[],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    ));
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
