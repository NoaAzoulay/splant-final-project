import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noa/common_widgets/custom_elevated_button.dart';

class SignInButton extends customElevatedButton {
  SignInButton({
    String text,
    MaterialStateProperty color,
    Color textColor,
   // VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 15.0),
          ),
         // bgcolor: color,
        //  onPressed: onPressed,
        );
}
