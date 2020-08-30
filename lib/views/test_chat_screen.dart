import 'package:flutter/material.dart';
//import 'random_string/randim_string';
import 'package:nearby_connections/nearby_connections.dart';

class TestChat extends StatefulWidget {
  @override
  _TestChatState createState() => _TestChatState();
}

class _TestChatState extends State<TestChat> {
  final String userID = 'kad99kev';
  final Strategy strategy = Strategy.P2P_CLUSTER;

  void acceptConnection(id) {
    Nearby().acceptConnection(id, onPayLoadRecieved: (endid, payload) async {
      print(payload);
//      String str = String.fromCharCode(payload.bytes);
//      print(str);
    });
  }

  void startAdvertising() async {
    try {
      bool adv = await Nearby().startAdvertising(
        userID,
        strategy,
        onConnectionInitiated: (id, info) async {
          try {
            acceptConnection(id);
          } catch (e) {
            print(e);
          }
        },
        onConnectionResult: (id, status) {
          if (status == Status.CONNECTED) {
            print('Connected to user: $id');
          }
        },
        onDisconnected: (id) {
          print('Disconnected from user: $id');
        },
      );
      print('Advertising: ${adv.toString()}');
    } catch (e) {
      print(e);
    }
  }

  void startDiscovery() async {
    try {
      bool disc = await Nearby().startDiscovery(userID, strategy,
          onEndpointFound: (id, name, serviceID) async {
        Nearby().requestConnection(
          userID,
          id,
          onConnectionInitiated: (id, info) async {
            try {
              acceptConnection(id);
            } catch (e) {
              print(e);
            }
          },
          onConnectionResult: (id, status) {
            if (status == Status.CONNECTED) {
              print('Connected to $id');
            }
            Nearby().stopDiscovery();
          },
          onDisconnected: (id) {
            print('Disconnected from $id');
          },
        );
      }, onEndpointLost: (id) {
        print('Lost $id');
      });
      print('Discovering: ${disc.toString()}');
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    Nearby().askLocationAndExternalStoragePermission();
    startAdvertising();
    startDiscovery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('Hello'),
      ),
    );
  }
}
