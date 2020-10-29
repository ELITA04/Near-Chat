import 'package:flutter/material.dart';
import 'package:near_chat/utils/constants.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  final bool sender;

  MessageBubble(
      {@required this.message, @required this.username, @required this.sender});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(sender: sender),
      child: Row(
        textDirection: sender ? TextDirection.rtl : TextDirection.ltr,
        children: [
          CircleAvatar(
            child: Text('${username[0].toUpperCase()}'),
          ),
          Padding(
            padding: EdgeInsets.all(5),
          ),
          Text(
            message,
            style: TextStyle(color: kBlack),
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
        ],
      ),
    );
  }
}

class BubblePainter extends CustomPainter {
  final bool sender;

  BubblePainter({@required this.sender});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = this.sender ? kPrimaryColour : kSecondaryColour;

    Path paintBubbleTail() {
      Path path;
      if (!sender) {
        path = Path()
          ..moveTo(5, size.height - 5)
          ..quadraticBezierTo(-5, size.height, -16, size.height - 4)
          ..quadraticBezierTo(-5, size.height - 5, 0, size.height - 17);
      }
      if (sender) {
        path = Path()
          ..moveTo(size.width - 6, size.height - 4)
          ..quadraticBezierTo(
              size.width + 5, size.height, size.width + 16, size.height - 4)
          ..quadraticBezierTo(
              size.width + 5, size.height - 5, size.width, size.height - 17);
      }
      return path;
    }

    final RRect bubbleBody = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(16));
    final Path bubbleTail = paintBubbleTail();

    canvas.drawRRect(bubbleBody, paint);
    canvas.drawPath(bubbleTail, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
