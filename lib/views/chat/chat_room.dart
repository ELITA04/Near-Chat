import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:near_chat/components/chat_room/message_bubble.dart';
import 'package:near_chat/components/chat_room/message_input.dart';
import 'package:near_chat/components/general/back_button.dart';
import 'package:nearby_connections/nearby_connections.dart';

class ChatRoom extends StatefulWidget {
  final String endpointID;
  final String endpointName;
  final String username;

  ChatRoom(
      {@required this.endpointID,
      @required this.endpointName,
      @required this.username});

  @override
  State createState() => ChatWindow();
}

class ChatWindow extends State<ChatRoom> with TickerProviderStateMixin {
  TextEditingController _editingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  final List<MessageBubble> _messages = <MessageBubble>[];
  final TextStyle textStyle = TextStyle(color: Colors.white);

  @override
  void initState() {
    Nearby().acceptConnection(widget.endpointID,
        onPayLoadRecieved: handlePayloadReceived,
        onPayloadTransferUpdate: handlePayloadStatus);
    super.initState();
  }

  void handlePayloadReceived(endid, payload) async {
    String str = String.fromCharCodes(payload.bytes);
    print(str);
    MessageBubble message = MessageBubble(
      message: str,
      username: widget.endpointName,
      sender: false,
    );
    setState(() {
      _messages.insert(0, message);
      print('lnegt ${_messages.length}');
    });
    // message.animationController.forward();
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

  @override
  void dispose() {
    // for (MessageBubble message in _messages) {
    //   // message.animationController.dispose();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              child: Text("${widget.endpointName[0].toUpperCase()}"),
            ),
            Text("${widget.endpointName}"),
          ],
        ),
        leading: GeneralBackButton(),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: ListView.builder(
                      itemBuilder: (_, int index) => _messages[index],
                      itemCount: _messages.length,
                      reverse: true,
                      padding: EdgeInsets.all(6.0),
                    ),
                  ),
                ],
              ),
            ),
            MessageInput(
              context: context,
              editingController: _editingController,
              focusNode: _focusNode,
            )
          ],
        ),
      ),
    );
    // message.animationController.forward();
  }

  void _submitMessage(String text) {
    _editingController.clear();
    Nearby().sendBytesPayload(
        widget.endpointID, Uint8List.fromList(text.codeUnits));
    MessageBubble message = MessageBubble(
      message: text,
      username: widget.username,
      sender: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }
}
