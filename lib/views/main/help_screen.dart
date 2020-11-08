import 'package:flutter/material.dart';

import 'package:near_chat/components/general/navigation_drawer.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: Text('Help!'),
        ),
        body: Text('Hi'));
  }
}
