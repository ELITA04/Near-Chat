import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:near_chat/components/chat_room/message_bubble.dart';
import 'package:near_chat/components/chat_room/message_input.dart';
import 'package:near_chat/components/general/back_button.dart';
import 'package:near_chat/utils/constants.dart';
import 'package:nearby_connections/nearby_connections.dart';

class ChatRoom extends StatefulWidget {
  final String endpointID;
  final String endpointName;
  final String username;
  final Function goBack;

  ChatRoom(
      {@required this.endpointID,
      @required this.endpointName,
      @required this.username,
      @required this.goBack});

  @override
  State createState() => ChatWindow();
}

class ChatWindow extends State<ChatRoom> with TickerProviderStateMixin {
  TextEditingController editingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  final List<MessageBubble> _messages = <MessageBubble>[];
  final TextStyle textStyle = TextStyle(color: Colors.white);
  Map<int, String> map = Map();
  File tempFile;

  @override
  void initState() {
    Nearby().acceptConnection(widget.endpointID,
        onPayLoadRecieved: handlePayloadReceived,
        onPayloadTransferUpdate: handlePayloadStatus);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kChatRoomBackground,
        bottomOpacity: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: kWhite,
              foregroundColor: kChatRoomBackground,
              radius: 15.0,
              child: Text(
                "${widget.endpointName[0].toUpperCase()}",
              ),
            ),
            SizedBox(width: 10.0),
            Text(
              "${widget.endpointName}",
              style: TextStyle(fontSize: 25.0, color: kWhite),
            ),
          ],
        ),
        titleSpacing: 0.0,
        leading: GeneralBackButton(
          goBack: widget.goBack,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                focusNode.unfocus();
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: ListView.builder(
                        itemBuilder: (_, int index) => _messages[index],
                        itemCount: _messages.length,
                        reverse: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          MessageInput(
            context: context,
            editingController: editingController,
            focusNode: focusNode,
            onSendMessage: sendMessage,
            onSendPicture: sendPicture,
          ),
        ],
      ),
    );
    // message.animationController.forward();
  }

  void handlePayloadReceived(endid, payload) async {
    if (payload.type == PayloadType.BYTES) {
      String str = String.fromCharCodes(payload.bytes);
      String time = getCurrentTime();

      if (str.contains('image_picker')) {
        // used for file payload as file payload is mapped as
        // payloadId:filename
        print('In str contains');
        int payloadId = int.parse(str.split(':')[0]);
        String fileName = (str.split(':')[1]);

        if (map.containsKey(payloadId)) {
          if (await tempFile.exists()) {
            print('Filename: ' + fileName);
            tempFile.rename(tempFile.parent.path + "/" + fileName);
          } else {
            print("File doesnt exist");
          }
        } else {
          //add to map if not already
          map[payloadId] = fileName;
        }
      } else {
        MessageBubble message = MessageBubble(
          message: str,
          username: widget.endpointName,
          sender: false,
          time: time,
        );
        setState(() {
          _messages.insert(0, message);
          print('lnegt ${_messages.length}');
        });
      }
    } else if (payload.type == PayloadType.FILE) {
      tempFile = File(payload.filePath);
      String time = getCurrentTime();

      MessageBubble message = MessageBubble(
        image: tempFile,
        username: widget.endpointName,
        sender: false,
        time: time,
      );
      setState(() {
        _messages.insert(0, message);
        print('lnegt ${_messages.length}');
      });
    }
  }

  void handlePayloadStatus(endid, payloadTransferUpdate) {
    if (payloadTransferUpdate.status == PayloadStatus.IN_PROGRRESS) {
      print(payloadTransferUpdate.bytesTransferred);
    } else if (payloadTransferUpdate.status == PayloadStatus.FAILURE) {
      print("failed");
      print(endid + ": FAILED to transfer file");
    } else if (payloadTransferUpdate.status == PayloadStatus.SUCCESS) {
      print("success, total bytes = ${payloadTransferUpdate.totalBytes}");
    }
  }

  void sendMessage(String text) {
    editingController.clear();
    Nearby().sendBytesPayload(
        widget.endpointID, Uint8List.fromList(text.codeUnits));
    String time = getCurrentTime();
    MessageBubble message = MessageBubble(
      message: text,
      username: widget.username,
      sender: true,
      time: time,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  void sendPicture(File image, String imagePath) async {
    if (imagePath == null) return;
    int payloadId =
        await Nearby().sendFilePayload(widget.endpointID, imagePath);
    Nearby().sendBytesPayload(
      widget.endpointID,
      Uint8List.fromList("$payloadId:${imagePath.split('/').last}".codeUnits),
    );
    String time = getCurrentTime();
    MessageBubble message = MessageBubble(
      image: image,
      username: widget.username,
      sender: true,
      time: time,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  String getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMM kk:mm').format(now);
    return formattedDate;
  }
}
