import 'package:flutter/material.dart';
import 'package:near_chat/animations/animations.dart';
import 'package:near_chat/views/auth/login.dart';
import 'package:near_chat/views/auth/sign_up.dart';
import 'package:near_chat/components/auth/coloured_button.dart';
import 'package:near_chat/utils/constants.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                        style: TextStyle(color: kDarkGrey, fontSize: 15),
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
                        image: AssetImage('assets/images/illustration.png'),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    FadeAnimation(
                      1.5,
                      ColouredButton(
                        text: 'Login',
                        borderSide: BorderSide(color: kBlack),
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
                              bottom: BorderSide(color: kBlack),
                              top: BorderSide(color: kBlack),
                              left: BorderSide(color: kBlack),
                              right: BorderSide(color: kBlack),
                            )),
                        child: ColouredButton(
                          text: 'Sign Up',
                          color: kPrimaryColour,
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
      ),
    );
  }
}
