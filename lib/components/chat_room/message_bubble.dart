import 'dart:io';

import 'package:flutter/material.dart';
import 'package:near_chat/utils/constants.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final File image;
  final String username;
  final String time;
  final bool sender;

  MessageBubble(
      {this.message,
      this.image,
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
          child: message != null
              ? Stack(
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
                )
              : Stack(children: <Widget>[
                  Image.file(image),
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(60.0)),
                        color: kBlack.withOpacity(0.5),
                      ),
                      child: Text(
                        time,
                        style: TextStyle(
                          color: kWhite,
                          fontSize: 8.0,
                        ),
                      ),
                    ),
                  )
                ]),
        )
      ],
    );
  }
}
