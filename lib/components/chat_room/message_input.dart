import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:near_chat/utils/constants.dart';

class MessageInput extends StatelessWidget {
  final BuildContext context;
  final TextEditingController editingController;
  final FocusNode focusNode;
  final Function onSend;

  MessageInput(
      {@required this.context,
      @required this.editingController,
      @required this.focusNode,
      @required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: kBlack,
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: editingController,
              focusNode: focusNode,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Say Something...',
                hintStyle: TextStyle(color: kChatRoomBackground),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kSecondaryColour),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColour),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              size: 30,
              color: kChatRoomBackground,
            ),
            onPressed: () {
              onSend(editingController.text);
            },
          ),
        ],
      ),
    );
  }
}
