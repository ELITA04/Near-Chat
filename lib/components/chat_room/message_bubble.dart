import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String text;
  final AnimationController animationController;
  final bool sender;
  final String username;

  Message(
      {@required this.text,
      @required this.animationController,
      @required this.sender,
      @required this.username});

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
          textDirection: sender ? TextDirection.rtl : TextDirection.ltr,
          children: <Widget>[
            Container(
              margin: sender
                  ? EdgeInsets.only(left: 18.0)
                  : EdgeInsets.only(right: 18.0),
              child: CircleAvatar(
                child: Text(username[0]),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(username, style: Theme.of(ctx).textTheme.subtitle1),
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
