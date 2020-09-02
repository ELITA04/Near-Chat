import 'dart:math';

import 'package:flutter/material.dart';
import 'package:near_chat/components/bottom_button.dart';
import 'package:near_chat/components/connection_init_sheet.dart';
import 'package:near_chat/components/discovered_users.dart';
import 'package:nearby_connections/nearby_connections.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final String userName = Random().nextInt(10000).toString();
  final Strategy strategy = Strategy.P2P_STAR;

  String connectedTo = 'None';
  List<DiscoveredUser> usersDiscovered = [];

  bool isAdvertising = false;
  bool isDiscovering = false;

  @override
  void initState() {
    Nearby().askLocationAndExternalStoragePermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('NearChat'),
        ),
        body: ListView(
          children: usersDiscovered,
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomControlButton(
                name: 'Start Advertising',
                icon: Icons.visibility,
                handler: handleAdvertising,
                isEnabled: isAdvertising,
              ),
              BottomControlButton(
                name: 'Start Discovery',
                icon: Icons.tap_and_play,
                handler: handleDiscovery,
                isEnabled: isDiscovering,
              ),
              BottomControlButton(
                name: 'Go Offline',
                icon: Icons.portable_wifi_off,
                handler: handleGoOffline,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleAdvertising(enable) async {
    isAdvertising = enable;
    if (enable) {
      try {
        await Nearby().startAdvertising(
          userName,
          strategy,
          onConnectionInitiated: onConnectionInit,
          onConnectionResult: (id, status) {
            showSnackbar(status);
          },
          onDisconnected: (id) {
            showSnackbar('Disconnected: $id');
          },
        );
      } catch (e) {
        print(e);
      }
    } else {
      await Nearby().stopAdvertising();
    }
  }

  void handleDiscovery(enable) async {
    isDiscovering = enable;
    if (enable) {
      try {
        await Nearby().startDiscovery(
          userName,
          strategy,
          onEndpointFound: (id, name, serviceId) {
            print('$id, $name');
            setState(() {
              usersDiscovered = List.from(usersDiscovered)
                ..add(
                  DiscoveredUser(
                    userID: id,
                    userName: name,
                    handleRequest: handleRequest,
                  ),
                );
            });
          },
          onEndpointLost: (id) {
            setState(() {
              usersDiscovered.removeWhere((element) => element.userID == id);
            });
          },
        );
      } catch (e) {
        print(e);
      }
    } else {
      setState(() {
        usersDiscovered = [];
      });
      await Nearby().stopDiscovery();
    }
  }

  void handleGoOffline(enable) async {
    await Nearby().stopAllEndpoints();
    setState(() {
      usersDiscovered = [];
      isAdvertising = false;
      isDiscovering = false;
    });
  }

  void showSnackbar(dynamic value) {
    final snackBar = SnackBar(
      content: Text(
        value.toString(),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void onConnectionInit(String id, ConnectionInfo info) {
    connectionInitSheet(context, id, info.authenticationToken,
        info.endpointName, info.isIncomingConnection.toString(), handleAccept);
  }

  void handleAccept(id) {
    connectedTo = id;
    Nearby().acceptConnection(
      id,
      onPayLoadRecieved: (endid, payload) async {
        String str = String.fromCharCodes(payload.bytes);
        showSnackbar('$endid: $str');
      },
      onPayloadTransferUpdate: (endid, payloadTransferUpdate) {
        if (payloadTransferUpdate.status == PayloadStatus.IN_PROGRRESS) {
          print(payloadTransferUpdate.bytesTransferred);
        } else if (payloadTransferUpdate.status == PayloadStatus.FAILURE) {
          print("failed");
          showSnackbar(endid + ": FAILED to transfer file");
        } else if (payloadTransferUpdate.status == PayloadStatus.SUCCESS) {
          showSnackbar(
              "success, total bytes = ${payloadTransferUpdate.totalBytes}");
        }
      },
    );
  }

  void handleRequest(id) {
    Nearby().requestConnection(
      userName,
      id,
      onConnectionInitiated: (id, info) {
        onConnectionInit(id, info);
      },
      onConnectionResult: (id, status) {
        showSnackbar(status);
      },
      onDisconnected: (id) {
        showSnackbar(id);
      },
    );
  }
}
