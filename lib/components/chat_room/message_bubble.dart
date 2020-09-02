import 'package:flutter/material.dart';

const String defaultUserName = "John Doe";

class Message extends StatelessWidget {
  Message({this.text, this.animationController});
  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext ctx) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.bounceOut),
      axisAlignment: 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 18.0),
              child: CircleAvatar(child: Text(defaultUserName[0])),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(defaultUserName,
                      style: Theme.of(ctx).textTheme.subtitle1),
                  Container(
                    margin: const EdgeInsets.only(top: 6.0),
                    child: Text(text),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
