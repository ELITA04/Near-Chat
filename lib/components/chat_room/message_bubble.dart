import 'package:flutter/material.dart';
import 'package:near_chat/utils/constants.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  final String time;
  final bool sender;

  MessageBubble(
      {@required this.message,
      @required this.username,
      @required this.sender,
      @required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          sender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(
              sender ? 15.0 : 5.0, 5.0, sender ? 5.0 : 15.0, 5.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: .5,
                spreadRadius: 1.0,
                color: kBlack.withOpacity(.12),
              )
            ],
            color: sender ? kPrimaryColour : kSecondaryColour,
            borderRadius: sender
                ? BorderRadius.only(
                    topLeft: Radius.circular(kBubbleRadius),
                    bottomLeft: Radius.circular(kBubbleRadius),
                    topRight: Radius.circular(kBubbleRadius),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(kBubbleRadius),
                    bottomLeft: Radius.circular(kBubbleRadius),
                    bottomRight: Radius.circular(kBubbleRadius),
                  ),
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 48.0),
                child: Text(
                  message,
                  textAlign: TextAlign.justify,
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Text(
                      time,
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 8.0,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
