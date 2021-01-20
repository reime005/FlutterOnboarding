import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  final int currentIndex;
  final int dataLength;
  final PageController controller;

  const BottomButtons(
      {Key key, this.currentIndex, this.dataLength, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: currentIndex == dataLength - 1
          ? [
              Expanded(
                child: ConstrainedBox(
                    constraints: new BoxConstraints(
                      maxHeight: 70.0,
                    ),
                    child: FlatButton(
                        onPressed: () {},
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.1,
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap, // add this
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: BorderSide.none),
                        child: Container(
                            child: Text(
                          "Get started",
                          style: Theme.of(context).textTheme.button,
                        )))),
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
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Row(
                children: [
                  FlatButton(
                    padding: EdgeInsets.zero,
                    minWidth: 0.0,
                    onPressed: () {
                      controller.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut);
                    },
                    child: Text(
                      "Next",
                      style: Theme.of(context).textTheme.bodyText1,
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
    );
  }
}
