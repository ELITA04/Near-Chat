import 'package:flutter/material.dart';
import 'package:near_chat/utils/constants.dart';

class GeneralBackButton extends StatelessWidget {
  final Function goBack;

  GeneralBackButton({this.goBack});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
        if (goBack != null) goBack();
      },
      icon: Icon(
        Icons.arrow_back_ios,
        size: 20,
        color: kPrimaryColour,
      ),
    );
  }
}
