import 'package:flutter/material.dart';
import 'package:flutter_app_jam_app/contains/constants.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      required this.onPressed,
      required this.buttontext,
      this.textColor = Constants.textButtonColor});

  final VoidCallback onPressed;
  final String buttontext;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        buttontext,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
