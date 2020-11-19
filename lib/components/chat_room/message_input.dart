import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:near_chat/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

class MessageInput extends StatelessWidget {
  final BuildContext context;
  final TextEditingController editingController;
  final FocusNode focusNode;
  final Function onSendMessage;
  final Function onSendPicture;
  final picker = ImagePicker();

  MessageInput(
      {@required this.context,
      @required this.editingController,
      @required this.focusNode,
      @required this.onSendMessage,
      @required this.onSendPicture});

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
          IconButton(
            icon: Icon(
              Icons.image,
              size: 30,
              color: kChatRoomBackground,
            ),
            onPressed: getImage,
          ),
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
              onSendMessage(editingController.text);
            },
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    previewImage(File(pickedFile.path), pickedFile.path);
  }

  void previewImage(image, path) {
    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Center(child: Text('Send Image?')),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.file(image),
                FlatButton(
                  color: kGreen,
                  child: Text(
                    'Send',
                    style: TextStyle(color: kBlack),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    onSendPicture(image, path);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
