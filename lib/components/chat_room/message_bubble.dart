import 'package:flutter/material.dart';

const String defaultUserName = "John Doe";

class Message extends StatelessWidget {
  Message({this.text, this.animationController, this.otherUserName});
  final String text;
  final AnimationController animationController;
  final String otherUserName;

  @override
  Widget build(BuildContext ctx) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.bounceOut),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection:
              otherUserName == null ? TextDirection.rtl : TextDirection.ltr,
          children: <Widget>[
            Container(
              margin: otherUserName == null
                  ? EdgeInsets.only(left: 18.0)
                  : EdgeInsets.only(right: 18.0),
              child: CircleAvatar(
                child: Text(
                    otherUserName != null ? otherUserName : defaultUserName[0]),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(otherUserName != null ? otherUserName : defaultUserName,
                    style: Theme.of(ctx).textTheme.subtitle1),
                Container(
                  margin: EdgeInsets.only(top: 6.0),
                  child: Text(text),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
