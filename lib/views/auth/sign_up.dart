import 'package:flutter/material.dart';
import 'package:near_chat/animations/animations.dart';
import 'package:near_chat/components/auth/input_field.dart';
import 'package:near_chat/components/auth/coloured_button.dart';
import 'package:near_chat/components/general/back_button.dart';
import 'package:near_chat/services/auth.service.dart';
import 'package:near_chat/utils/constants.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                      "Sign Up!",
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
                      "Create an account, It's free",
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
                    1.4,
                    InputField(
                      label: "Enter Username",
                      controller: usernameController,
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
                    text: 'Register',
                    color: kSecondaryColour,
                    action: () {
                      signUp(context);
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
      builder: (_) => new AlertDialog(
        title: new Text(title),
        content: new Text(text),
        actions: <Widget>[
          FlatButton(
            child: Text(buttonText),
            onPressed: onPressed,
          )
        ],
      ),
    );
  }

  void signUp(BuildContext context) {
    registerUser(emailController.text, usernameController.text,
            passwordController.text)
        .then(
      (value) {
        print(value);
        if (value != 'success') {
          _showAlert(context, "An Error has Occurred!", value, "Try Again", () {
            Navigator.pop(context);
          });
        } else {
          _showAlert(
              context,
              "Success!",
              "You've been registered successfully! Please login to begin chatting!",
              "Proceed", () {
            Navigator.popUntil(context, (route) => route.isFirst);
          });
        }
      },
    );
  }
}
