import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:near_chat/views/auth/login.dart';
import 'package:near_chat/views/auth/sign_up.dart';
import 'package:near_chat/utils/constants.dart';
import 'package:near_chat/views/main/home_screen.dart';
import 'package:near_chat/views/main/welcome_screen.dart';
import 'package:near_chat/views/main/help_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  bool registered = await initHive();
  runApp(NearChat(
    registered: registered,
  ));
}

Future<bool> initHive() async {
  await Hive.openBox('user');
  bool registered = Hive.box('user').containsKey('username');
  return registered;
}

class NearChat extends StatefulWidget {
  final bool registered;

  NearChat({@required this.registered});

  @override
  _NearChatState createState() => _NearChatState();
}

class _NearChatState extends State<NearChat> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColour,
        accentColor: kSecondaryColour,
        accentColorBrightness: Brightness.dark,
      ),
      routes: {
        '/home': (context) => HomeScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/help': (context) => HelpScreen(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage()
      },
      home: widget.registered ? HomeScreen() : WelcomeScreen(),
    );
  }
}
