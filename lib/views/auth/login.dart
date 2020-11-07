import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:near_chat/animations/animations.dart';
import 'package:near_chat/components/auth/input_field.dart';
import 'package:near_chat/components/auth/coloured_button.dart';
import 'package:near_chat/components/general/back_button.dart';
import 'package:near_chat/services/auth.service.dart';
import 'package:near_chat/utils/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: kWhite,
        leading: GeneralBackButton(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Text(
                      "Login!",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                    1.2,
                    Text(
                      "Login to your account",
                      style: TextStyle(fontSize: 15, color: kGrey),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  FadeAnimation(
                    1.2,
                    InputField(
                      label: "Email",
                      controller: emailController,
                    ),
                  ),
                  FadeAnimation(
                    1.3,
                    InputField(
                      label: "Enter Password",
                      obscureText: true,
                      controller: passwordController,
                    ),
                  ),
                ],
              ),
              FadeAnimation(
                1.5,
                Container(
                  padding: EdgeInsets.only(top: 3, left: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border(
                      bottom: BorderSide(color: kBlack),
                      top: BorderSide(color: kBlack),
                      left: BorderSide(color: kBlack),
                      right: BorderSide(color: kBlack),
                    ),
                  ),
                  child: ColouredButton(
                    text: 'Submit',
                    color: kSecondaryColour,
                    action: () {
                      login(context);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlert(BuildContext context, String title, String text,
      String buttonText, Function onPressed) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: <Widget>[
          FlatButton(
            child: Text(buttonText),
            onPressed: onPressed,
          )
        ],
      ),
    );
  }

  void login(BuildContext context) {
    loginUser(emailController.text, passwordController.text).then(
      (value) {
        print(value);
        if (value is String) {
          _showAlert(
            context,
            "An Error has Occurred!",
            value,
            "Try Again",
            () {
              Navigator.pop(context);
            },
          );
        } else {
          Hive.box('user').put('username', value['username']);
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }
      },
    );
  }
}
