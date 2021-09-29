import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Splant',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'IndieFlower', fontSize: 30),
            ),
            Icon(FontAwesomeIcons.leaf,
              size: 12,
              color: Colors.white70,
            )
          ],
        ),
        backgroundColor: Colors.green,
      ),

    );
  }
}
