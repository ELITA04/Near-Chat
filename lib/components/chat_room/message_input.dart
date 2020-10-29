import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({
    Key key,
    @required this.context,
    @required TextEditingController editingController,
    @required FocusNode focusNode,
  })  : _editingController = editingController,
        _focusNode = focusNode,
        super(key: key);

  final BuildContext context;
  final TextEditingController _editingController;
  final FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        child: Container(
          padding: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.withOpacity(0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _editingController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(hintText: 'Say something...'),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.send,
                  size: 30,
                ),
                onPressed: () {
                  print(_editingController.text);
                },
              ),
            ],
          ),
        ));
  }
}
