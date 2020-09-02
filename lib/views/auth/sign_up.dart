import 'package:flutter/material.dart';
import 'package:near_chat/animations/animations.dart';
import 'package:near_chat/components/auth/input_field.dart';
import 'package:near_chat/components/auth/coloured_button.dart';

import 'package:near_chat/services/auth.service.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _passwordVerify = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
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
                          "Sign up",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                      1.2,
                      Text(
                        "Create an account, It's free",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
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
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                      ),
                    ),
                    FadeAnimation(
                      1.4,
                      InputField(
                        label: "Confirm Password",
                        obscureText: true,
                        controller: confirmPasswordController,
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
                        bottom: BorderSide(color: Colors.black),
                        top: BorderSide(color: Colors.black),
                        left: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black),
                      ),
                    ),
                    child: ColouredButton(
                      text: 'SignUp',
                      color: Colors.greenAccent,
                      action: signUp,
                    ),
                  ),
                ),
                FadeAnimation(
                  1.6,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already have an account?"),
                      Text(
                        " Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void signUp() {
    print('Sign up');
    print(emailController.text);
    print(passwordController.text);
    print(confirmPasswordController.text);
    registerUser(emailController.text, passwordController.text);
  }
}
