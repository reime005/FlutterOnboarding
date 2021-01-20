import 'package:flutter_onboarding/botton_buttons.dart';
import 'package:flutter_onboarding/explanation.dart';

import 'package:flutter/material.dart';

final List<ExplanationData> data = [
  ExplanationData(
      description:
          "Labore do ex cillum fugiat anim nulla pariatur est. Elit laboris eiusmod ex occaecat do ea officia esse culpa.",
      title: "A Day at the Park",
      localImageSrc: "assets/1.svg",
      backgroundColor: Colors.orange[500]),
  ExplanationData(
      description:
          "Sit ullamco anim deserunt aliquip mollit id. Occaecat labore laboris magna reprehenderit sint in sunt ea.",
      title: "Playing Fetch",
      localImageSrc: "assets/2.svg",
      backgroundColor: Colors.orange[700]),
  ExplanationData(
      description:
          "Eiusmod aliqua laboris duis eiusmod ea ea commodo dolore. Ullamco nulla nostrud et officia.",
      title: "Relaxing Walk",
      localImageSrc: "assets/3.svg",
      backgroundColor: Colors.green[800]),
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> /*with ChangeNotifier*/ {
  final _controller = PageController();

  int _currentIndex = 0;

  // OpenPainter _painter = OpenPainter(3, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: data[_currentIndex].backgroundColor,
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.all(16),
          color: data[_currentIndex].backgroundColor,
          alignment: Alignment.center,
          child: Column(children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: PageView(
                              scrollDirection: Axis.horizontal,
                              controller: _controller,
                              onPageChanged: (value) {
                                // _painter.changeIndex(value);
                                setState(() {
                                  _currentIndex = value;
                                });
                                // notifyListeners();
                              },
                              children: data
                                  .map((e) => ExplanationPage(data: e))
                                  .toList())),
                      flex: 4),
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
                          BottomButtons(
                            currentIndex: _currentIndex,
                            dataLength: data.length,
                            controller: _controller,
                          )
                        ],
                      ))
                ],
              ),
            )
          ]),
        )));
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
