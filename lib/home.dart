import 'package:flutter_onboarding/explanation.dart';

import 'package:flutter/material.dart';

final List<ExplanationData> data = [
  ExplanationData(
      description:
          "Labore do ex cillum fugiat anim nulla pariatur est. Elit laboris eiusmod ex occaecat do ea officia esse culpa sit amet occaecat.",
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
  final controller = PageController();

  int _currentIndex = 0;

  // OpenPainter _painter = OpenPainter(3, 1);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                          controller: controller,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _currentIndex == data.length - 1
                            ? [
                                Expanded(
                                  child: FlatButton(
                                      onPressed: () {},
                                      color: Colors.white,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize
                                              .shrinkWrap, // add this
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          side: BorderSide.none),
                                      child: Container(
                                          padding: EdgeInsets.all(24),
                                          child: Text(
                                            "Get started",
                                            style: Theme.of(context)
                                                .textTheme
                                                .button,
                                          ))),
                                )
                              ]
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
                                    Container(
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.arrow_right_alt,
                                          color: Colors.white,
                                        ))
                                  ],
                                )
                              ],
                      )
                    ],
                  ))
            ],
          ),
        )
      ]),
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
