import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:near_chat/components/home_screen/bottom_button.dart';
import 'package:near_chat/components/home_screen/connection_init_sheet.dart';
import 'package:near_chat/components/home_screen/discovered_users.dart';
import 'package:near_chat/views/chat/chat_room.dart';
import 'package:nearby_connections/nearby_connections.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Strategy strategy = Strategy.P2P_STAR;
  String userName;

  String connectedTo = 'None';
  List<DiscoveredUser> usersDiscovered = [];

  bool isAdvertising = false;
  bool isDiscovering = false;

  @override
  void initState() {
    Nearby().askLocationAndExternalStoragePermission();
    super.initState();
    var result = Hive.box('user').get('username');
    userName = result;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(userName),
        ),
        body: usersDiscovered.length < 1
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text('No Users Near You!'),
                  ),
                ],
              )
            : ListView(
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
              FlatButton(
                child: Text('XXX'),
                onPressed: () {
                  Hive.box('user').delete('username');
                },
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

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatRoom(
          endpointID: id,
        ),
      ),
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
        if (status == Status.CONNECTED) {
          showSnackbar(status);
        }
      },
      onDisconnected: (id) {
        showSnackbar(id);
      },
    );
  }
}
