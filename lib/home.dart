import 'dart:developer';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController();

  OpenPainter _painter = OpenPainter(3, 1);
  bool _lights = false;
  int _index = 0;

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
                      setState(() {
                        _index = value;
                      });
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
                            "Walk your dog $_index",
                            style: Theme.of(context).textTheme.headline1,
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 32, left: 16, right: 16),
                              child: Text(
                                "Reprehenderit ea ut cupidatat proident. Mollit proident eiusmod ad ex cillum officia dolore amet. Cillum amet eiusmod occaecat non non consectetur laborum do. Cupidatat dolore enim officia mollit.",
                                style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.center,
                              )),
                        ],
                      )),
                      Container(
                        width: 80,
                        height: 80,
                        child: CustomPaint(
                          painter: _painter,
                        ),
                      ),
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

class OpenPainter extends CustomPainter {
  final int maxIndex;
  int currentIndex = 1;

  void changeIndex(int index) {
    currentIndex = index + 1;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xff63aa65)
      ..style = PaintingStyle.fill;

    var radius = 10.0;
    var distance = 0.0;
    var gap = 10.0;

    for (int i = 1; i <= maxIndex; i++) {
      if (i == currentIndex) {
        canvas.drawRRect(
            RRect.fromRectAndCorners(Rect.fromLTRB(distance - radius, -5, distance + radius * 3, 5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5)),
            paint1);

        distance += (radius * 2 * 2) + gap;
        continue;
      }

      canvas.drawCircle(Offset(distance, 0), radius, paint1);
      distance += (radius * 2) + gap;
    }

    //a circle
    // canvas.drawLine(Offset(0, 0), Offset(10.0 * _index, 0), paint1);
    // canvas.drawCircle(Offset(24, 24), 24, paint1);
  }

  OpenPainter(this.maxIndex, this.currentIndex) {}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
