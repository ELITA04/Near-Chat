import 'package:flutter/material.dart';
import 'package:near_chat/utils/constants.dart';

class InputField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;

  InputField(
      {@required this.label,
      @required this.controller,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: kBlack),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kSecondaryColour),
            ),
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
