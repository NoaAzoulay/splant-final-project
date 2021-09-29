import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final double radius;
  final MaterialStateProperty bgcolor;
  final VoidCallback onPressed;
  final Color borderColor;
  final Widget child;
  final double height;
  final Color buttonColor;
  final double borderWidth;

  CustomElevatedButton({
    this.child,
    this.bgcolor,
    this.radius: 4.0,
    this.onPressed,
    this.borderColor,
    this.height: 40.0,
    this.buttonColor,
    this.borderWidth: 2,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        //text
        child: child,
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius),
                    side: BorderSide(color: borderColor, width: borderWidth))),
            backgroundColor: bgcolor,
            ),
      ),
    );
  }
}
