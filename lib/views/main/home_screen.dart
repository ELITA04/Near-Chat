import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nearby_connections/nearby_connections.dart';

import 'package:near_chat/components/home_screen/bottom_button.dart';
import 'package:near_chat/components/home_screen/connection_alert.dart';
import 'package:near_chat/components/home_screen/discovered_users.dart';
import 'package:near_chat/components/general/navigation_drawer.dart';
import 'package:near_chat/utils/constants.dart';
import 'package:near_chat/views/chat/chat_room.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Strategy strategy = Strategy.P2P_STAR;
  String username;

  String connectedTo = 'None';
  List<DiscoveredUser> usersDiscovered = [
    DiscoveredUser(
      userID: 'DUMMY',
      userName: 'DUMMY',
      handleRequest: () {},
      darkShade: false,
    )
  ];

  bool isAdvertising = false;
  bool isDiscovering = false;

  @override
  void initState() {
    Nearby().askLocationAndExternalStoragePermission();
    super.initState();
    var result = Hive.box('user').get('username');
    username = result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(username),
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
        color: kSecondaryColour,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BottomControlButton(
              name: 'Advertising',
              enableIcon: Icons.visibility,
              disableIcon: Icons.visibility_off,
              handler: handleAdvertising,
              isEnabled: isAdvertising,
            ),
            BottomControlButton(
              name: 'Discovery',
              enableIcon: Icons.cast_connected,
              disableIcon: Icons.cast,
              handler: handleDiscovery,
              isEnabled: isDiscovering,
            ),
            BottomControlButton(
              name: 'Go Offline',
              enableIcon: Icons.portable_wifi_off,
              handler: handleGoOffline,
            ),
          ],
        ),
      ),
    );
  }

  void handleAdvertising(enable) async {
    isAdvertising = enable;
    if (enable) {
      try {
        await Nearby().startAdvertising(
          username,
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
          username,
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
                    darkShade: usersDiscovered.length % 2 == 1 ? true : false,
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
    print(info.endpointName);
    connectionAlert(
      context,
      id,
      info.authenticationToken,
      info.endpointName,
      info.isIncomingConnection.toString(),
      () {
        handleAccept(id, info.endpointName);
      },
      () {
        handleReject();
      },
    );
  }

  void handleReject() {
    Nearby().stopAllEndpoints().then((_) {
      handleDiscovery(isDiscovering);
      handleAdvertising(isAdvertising);
      setState(() {
        usersDiscovered = [];
      });
    });
  }

  void handleAccept(id, endpointName) {
    connectedTo = id;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatRoom(
          endpointID: id,
          endpointName: endpointName,
          username: username,
          goBack: handleReject,
        ),
      ),
    );
  }

  void handleRequest(id) {
    try {
      Nearby().requestConnection(
        username,
        id,
        onConnectionInitiated: (id, info) {
          onConnectionInit(id, info);
        },
        onConnectionResult: (id, status) {},
        onDisconnected: (id) {},
      );
    } catch (e) {
      print(e);
    }
  }
}
