import 'package:flutter/material.dart';
import 'package:near_chat/views/main/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(NearChat());
}

class NearChat extends StatefulWidget {
  @override
  _NearChatState createState() => _NearChatState();
}

class _NearChatState extends State<NearChat> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
