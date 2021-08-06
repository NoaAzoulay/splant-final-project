
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noa/common_widgets/custom_elevated_button.dart';

class FormSubmitButton extends customElevatedButton{
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
    hight: 44.0,
    borderColor: Colors.green,
    radius: 4.0,
    onPressed: onPressed,
    bgcolor: MaterialStateProperty.all<Color>(Colors.green),
  );
}