import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noa/customWidgets/custom_elevated_button.dart';

class FormSubmitButton extends CustomElevatedButton{
  FormSubmitButton({
    String text,
    VoidCallback onPressed,
}): super(
    child: Text(text,
    style: TextStyle(
      color: Colors.white,
      fontSize: 22.0,
    ),
    ),
    height: 44.0,
    borderColor: Colors.green,
    radius: 4.0,
    onPressed: onPressed,
    bgcolor: MaterialStateProperty.all<Color>(Colors.green),
  );
}