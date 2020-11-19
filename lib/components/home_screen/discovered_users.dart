import 'package:flutter/material.dart';
import 'package:near_chat/utils/constants.dart';
// import 'package:near_chat/utils/constants.dart';

class DiscoveredUser extends StatefulWidget {
  final String userID;
  final String userName;
  final Function handleRequest;
  final bool darkShade;

  DiscoveredUser(
      {@required this.userID,
      @required this.userName,
      @required this.handleRequest,
      @required this.darkShade});

  @override
  _DiscoveredUserState createState() => _DiscoveredUserState();
}

class _DiscoveredUserState extends State<DiscoveredUser> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0.0),
      child: Padding(
        padding: EdgeInsets.fromLTRB(8.0, 3.5, 8.0, 3.0),
        child: Container(
          decoration: BoxDecoration(
            color: kWhite,
            border: Border.all(
              color: kPrimaryColour,
              width: 2.0,
            ),
            boxShadow: [
              BoxShadow(
                color: kPrimaryColour,
                blurRadius: 5.0,
              )
            ],
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: kRed,
                      child: Text(widget.userName[0],
                          style: TextStyle(color: kDarkGrey)),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      widget.userName,
                      style: TextStyle(
                        color: kDarkGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text('User ID: ${widget.userID}')
              ],
            ),
          ),
        ),
      ),
      onPressed: () {
        widget.handleRequest(widget.userID);
      },
    );
  }
}
