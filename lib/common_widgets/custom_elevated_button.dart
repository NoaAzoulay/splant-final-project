import 'package:flutter/material.dart';

class customElevatedButton extends StatelessWidget {
  final double radius;
  final MaterialStateProperty bgcolor;
  final VoidCallback onPressed;
  final Color borderColor;
  final Widget child;
  final double hight;
  final Color buttonColor;

  customElevatedButton({
    this.child,
    this.bgcolor,
    this.radius: 4.0,
    this.onPressed,
    this.borderColor,
    this.hight: 40.0,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hight,
      child: ElevatedButton(
        onPressed: onPressed,
        //text
        child: child,
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius),
                    side: BorderSide(color: borderColor))),
            backgroundColor: bgcolor,
            //MaterialStateProperty.all<Color>(Colors.white),
            ),


      ),
    );
  }
}
