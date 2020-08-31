import 'package:flutter/material.dart';

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
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RaisedButton(
            child: Icon(widget.icon),
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
          Text('${widget.isEnabled}'),
        ],
      ),
    );
  }
}
