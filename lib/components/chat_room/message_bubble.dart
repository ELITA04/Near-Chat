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
    final bg = sender ? kPrimaryColour : kSecondaryColour;
    final align = sender ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = sender
        ? BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            topRight: Radius.circular(10.0),
          )
        : BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: .5,
                spreadRadius: 1.0,
                color: kBlack.withOpacity(.12),
              )
            ],
            color: bg,
            borderRadius: radius,
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 48.0),
                child: Text(message),
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
