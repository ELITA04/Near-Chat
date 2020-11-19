import 'package:flutter/material.dart';
import 'package:near_chat/utils/constants.dart';

// ignore: must_be_immutable
class BottomControlButton extends StatefulWidget {
  final String name;
  final IconData enableIcon;
  final IconData disableIcon;
  final Function handler;
  bool isEnabled;

  BottomControlButton(
      {@required this.name,
      @required this.enableIcon,
      @required this.handler,
      this.disableIcon,
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
          FlatButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: Icon(
              widget.isEnabled == null ||
                      widget.disableIcon == null ||
                      widget.isEnabled
                  ? widget.enableIcon
                  : widget.disableIcon,
              color:
                  widget.isEnabled == null || widget.isEnabled ? kWhite : kDarkGrey,
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
            '${widget.name}',
            style: TextStyle(
              color:
                  widget.isEnabled == null || widget.isEnabled ? kWhite : kDarkGrey,
            ),
          ),
        ],
      ),
    );
  }
}
