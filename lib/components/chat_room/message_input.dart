import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MessageInput extends StatefulWidget {
  final TextEditingController textController;
  final Function onSubmit;

  MessageInput({@required this.textController, @required this.onSubmit});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  bool isWriting = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 9.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: widget.textController,
              onChanged: (String text) {
                setState(() {
                  isWriting = text.length > 0;
                });
              },
              onSubmitted: widget.onSubmit,
              decoration: InputDecoration.collapsed(
                  hintText: "Enter text to send message"),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 3.0),
            child: Theme.of(context).platform == TargetPlatform.iOS
                ? CupertinoButton(
                    child: Text("Submit"),
                    onPressed: isWriting
                        ? () {
                            widget.onSubmit(widget.textController.text);
                            setState(() {
                              isWriting = false;
                            });
                          }
                        : null)
                : IconButton(
                    icon: Icon(Icons.message),
                    onPressed: isWriting
                        ? () {
                            widget.onSubmit(widget.textController.text);
                            setState(() {
                              isWriting = false;
                            });
                          }
                        : null),
          ),
        ],
      ),
    );
  }
}
