import 'package:flutter/material.dart';
import 'package:near_chat/utils/constants.dart';

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
    return Container(
      decoration: BoxDecoration(color: widget.darkShade ? kDarkGrey : kGrey),
      padding: EdgeInsets.all(8.0),
      child: FlatButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text('${widget.userName[0]}'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                ),
                Text(
                  '${widget.userName}',
                  style: TextStyle(color: kPrimaryColour),
                ),
              ],
            ),
            Text(
              'User ID: ${widget.userID}',
              style: TextStyle(color: kPrimaryColour),
            ),
          ],
        ),
        onPressed: () {
          widget.handleRequest(widget.userID);
        },
      ),
    );
  }
}
