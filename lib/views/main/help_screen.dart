import 'package:flutter/material.dart';

import 'package:near_chat/components/general/navigation_drawer.dart';
import 'package:near_chat/utils/constants.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('How to Use?'),
      ),
      body: ListView(
        children: [
          HelpInfo(
            title: 'Advertising',
            body:
                'Advertising shows that you are open to connections. Enabling it lets other users know that you are open to connect. Disabling it prevents from others from knowing you are available, however with Discovery on you can still send a request to others.',
            icon: Icons.visibility,
          ),
          SizedBox(height: 5.0),
          HelpInfo(
            title: 'Discovery',
            body:
                'Discovering enables you to discover other devices that are advertising near you. You can only see those devices that are currently advertising. Disabling Discovery simply stops you from discovering other devices, however if you still have advertising enabled, others can still send you a request.',
            icon: Icons.wifi,
          ),
          SizedBox(height: 5.0),
          HelpInfo(
            title: 'Go Offline',
            body:
                'This is a quick control option that switches you offline. This means that you will no longer be advertising nor discovering.',
            icon: Icons.portable_wifi_off,
          ),
        ],
      ),
    );
  }
}

class HelpInfo extends StatelessWidget {
  final String title;
  final String body;
  final IconData icon;

  HelpInfo({@required this.title, @required this.body, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon),
                  SizedBox(width: 5.0),
                  Text(
                    title,
                    style: TextStyle(
                      color: kBlack,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              ),
              Text(
                body,
                style: TextStyle(
                  color: kBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
