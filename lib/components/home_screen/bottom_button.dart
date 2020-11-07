import 'package:flutter/material.dart';
import 'package:near_chat/utils/constants.dart';

// ignore: must_be_immutable
class BottomControlButton extends StatefulWidget {
  final String name;
  final IconData icon;
  final Function handler;
  bool isEnabled;

  BottomControlButton(
      {@required this.name,
      @required this.icon,
      @required this.handler,
      this.isEnabled});

  @override
  _BottomControlButtonState createState() => _BottomControlButtonState();
}

class _BottomControlButtonState extends State<BottomControlButton> {
  @override
  Widget build(BuildContext context) {
    String bottomName =
        widget.isEnabled != null ? widget.isEnabled ? 'Stop' : 'Start' : '';

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FlatButton(
            child: Icon(
              widget.icon,
              color:
                  widget.isEnabled == null || widget.isEnabled ? kWhite : kGrey,
            ),
            onPressed: () {
              if (widget.isEnabled == null) {
                widget.handler(false);
              } else {
                widget.isEnabled = !widget.isEnabled;
                widget.handler(widget.isEnabled);
              }
              setState(() {});
            },
          ),
          Text(
            bottomName,
            style: TextStyle(
              color:
                  widget.isEnabled == null || widget.isEnabled ? kWhite : kGrey,
            ),
          ),
          Text(
            '${widget.name}',
            style: TextStyle(
              color:
                  widget.isEnabled == null || widget.isEnabled ? kWhite : kGrey,
            ),
          ),
        ],
      ),
    );
  }
}
