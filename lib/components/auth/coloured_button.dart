import 'package:flutter/material.dart';

class ColouredButton extends StatelessWidget {
  final Color color;
  final String text;
  final BorderSide borderSide;
  final Function action;
  final Widget page;

  ColouredButton(
      {@required this.text,
      this.color,
      this.borderSide,
      this.action,
      this.page});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 60,
      onPressed: () {
        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
        } else if (action != null) {
          action();
        }
      },
      color: color != null ? color : null,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: borderSide != null
            ? borderSide
            : BorderSide(width: 0.0, color: color),
      ),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      ),
    );
  }
}
