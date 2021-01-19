import 'dart:developer';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class ExplanationPage extends StatelessWidget {
  final String title;
  final String description;
  final String resourceName;

  final List<Widget> extra;

  ExplanationPage(
      {this.title, this.description, this.resourceName, this.extra});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(children: [
      Expanded(
          flex: 3,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SvgPicture.asset(resourceName,
                    height: MediaQuery.of(context).size.height * 0.4,
                    alignment: Alignment.center),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.center,
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: 32, left: 16, right: 16, bottom: 16),
                    child: Text(
                      description,
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: 32, left: 16, right: 16, bottom: 16),
                    child: Text(
                      description,
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: 32, left: 16, right: 16, bottom: 16),
                    child: Text(
                      description,
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          )),
      Column(children: extra),
      Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
          ))
    ]));
  }
}

class _HomePageState extends State<HomePage> with ChangeNotifier {
  final controller = PageController();

  OpenPainter _painter = OpenPainter(3, 1);

  test() {
    return CustomPaint(
      painter: _painter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: Colors.orange[500],
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
                          notifyListeners();
                        },
                        children: [
                          ExplanationPage(
                            description:
                                "Adipisicing nulla aliquip ea ad aute qui do. Enim id id dolor dolore laboris tempor commodo qui et do qui dolor dolore. Voluptate ex et enim magna ad aute nisi non commodo esse quis. Aliquip sunt anim duis ea ut exercitation voluptate. Duis officia duis magna anim ex velit id sunt commodo ad amet proident aliqua excepteur.",
                            resourceName: "assets/1.svg",
                            title: "Walk your dog",
                            extra: [this.test()],
                          ),
                          ExplanationPage(
                            description:
                                "Adipisicing nulla aliquip ea ad aute qui do. Enim id id dolor dolore laboris tempor commodo qui et do qui dolor dolore. Voluptate ex et enim magna ad aute nisi non commodo esse quis. Aliquip sunt anim duis ea ut exercitation voluptate. Duis officia duis magna anim ex velit id sunt commodo ad amet proident aliqua excepteur.",
                            resourceName: "assets/1.svg",
                            title: "Walk your dog",
                            extra: [this.test()],
                          ),
                          ExplanationPage(
                              description:
                                  "Adipisicing nulla aliquip ea ad aute qui do. Enim id id dolor dolore laboris tempor commodo qui et do qui dolor dolore. Voluptate ex et enim magna ad aute nisi non commodo esse quis. Aliquip sunt anim duis ea ut exercitation voluptate. Duis officia duis magna anim ex velit id sunt commodo ad amet proident aliqua excepteur.",
                              resourceName: "assets/1.svg",
                              title: "Walk your dog",
                              extra: [this.test()]),
                        ],
                      )),
                  flex: 1),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1),
              child: CustomPaint(
                painter: _painter,
              )),
        ],
      ),
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
