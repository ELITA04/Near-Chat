import 'package:flutter/material.dart';

class DiscoveredUser extends StatefulWidget {
  final String userID;
  final String userName;
  final Function handleRequest;

  DiscoveredUser(
      {@required this.userID,
      @required this.userName,
      @required this.handleRequest});

  @override
  _DiscoveredUserState createState() => _DiscoveredUserState();
}

class _DiscoveredUserState extends State<DiscoveredUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${widget.userID}'),
            Text('${widget.userName}'),
          ],
        ),
        onPressed: () {
          widget.handleRequest(widget.userID);
        },
      ),
    );
  }
}
