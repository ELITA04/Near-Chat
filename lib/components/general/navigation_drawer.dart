import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:near_chat/utils/constants.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  String username;

  @override
  void initState() {
    super.initState();
    var result = Hive.box('user').get('username');
    username = result;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 100.0,
            child: DrawerHeader(
              child: Center(
                child: Text(
                  'Welcome $username!',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 25.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [kSecondaryColour, kPrimaryColour])),
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(10.0),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.home),
                SizedBox(
                  width: 3.0,
                ),
                Text('Home'),
              ],
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/home');
            },
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.help_outline),
                SizedBox(
                  width: 3.0,
                ),
                Text('How to Use?'),
              ],
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/help');
            },
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.logout),
                SizedBox(
                  width: 3.0,
                ),
                Text('Logout'),
              ],
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Hive.box('user').delete('username');
              Navigator.popAndPushNamed(context, '/welcome');
            },
          ),
        ],
      ),
    );
  }
}
