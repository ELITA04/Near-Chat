import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:near_chat/components/chat_room/message_bubble.dart';
import 'package:near_chat/components/chat_room/message_input.dart';
import 'package:nearby_connections/nearby_connections.dart';

class ChatRoom extends StatefulWidget {
  final String endpointID;

  ChatRoom({@required this.endpointID});

  @override
  State createState() => ChatWindow();
}

class ChatWindow extends State<ChatRoom> with TickerProviderStateMixin {
  final List<Message> _messages = <Message>[];
  final TextEditingController _textController = TextEditingController();

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
    Message message = Message(
      text: str,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 800)),
      otherUserName: widget.endpointID,
    );
    setState(() {
      _messages.insert(0, message);
      print('lnegt ${_messages.length}');
    });
    message.animationController.forward();
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
    for (Message message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat App"),
      ),
      body: Column(
        children: <Widget>[
          Text('${widget.endpointID}'),
          Flexible(
            child: ListView.builder(
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
              reverse: true,
              padding: EdgeInsets.all(6.0),
            ),
          ),
          Divider(height: 1.0),
          Container(
            child: MessageInput(
              textController: _textController,
              onSubmit: _submitMessage,
            ),
            decoration: BoxDecoration(color: Colors.white),
          ),
        ],
      ),
    );
  }

  void _submitMessage(String text) {
    _textController.clear();
    Nearby().sendBytesPayload(
        widget.endpointID, Uint8List.fromList(text.codeUnits));
    Message message = Message(
      text: text,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 800)),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }
}
