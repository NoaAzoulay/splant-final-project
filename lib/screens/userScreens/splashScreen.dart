import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SplashPage extends StatelessWidget {
  int duration =0;
  Widget goToPage;
  SplashPage({this.duration, this.goToPage});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: this.duration),(){
      Navigator.push(context, MaterialPageRoute(
          builder: (context)=>goToPage));
    });
    return Scaffold(
      body:
      Container(
        color: Colors.green[600],
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text('Splant',
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.white,
                  //       fontSize: 70,
                  //       fontFamily: 'IndieFlower',
                  //     letterSpacing: 2
                  //   ),),
                  Icon(FontAwesomeIcons.leaf,
                  size: 50,
                      color: Colors.white,),

                ],
              ),
            ],
          ),
        ),
      ) ,
    );
  }
}
