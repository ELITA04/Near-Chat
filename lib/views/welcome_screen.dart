import 'package:flutter/material.dart';
import 'package:near_chat/animations/animations.dart';
import 'package:near_chat/views/login.dart';
import 'package:near_chat/views/sign_up.dart';
import 'package:near_chat/components/coloured_button.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SafeArea(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FadeAnimation(
                        1,
                        Text(
                          "Welcome",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                        1.2,
                        Text(
                          "Chat with people in your vicinity!",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  FadeAnimation(
                    1.4,
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/illustration.png'))),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      FadeAnimation(
                        1.5,
                        ColouredButton(
                          text: 'Login',
                          borderSide: BorderSide(color: Colors.black),
                          page: LoginPage(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                        1.6,
                        Container(
                          padding: EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                              )),
                          child: ColouredButton(
                            text: 'SignUp',
                            color: Colors.yellow,
                            page: SignUpPage(),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
