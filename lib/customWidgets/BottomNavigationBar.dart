import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noa/screens/plants/userPlants.dart';
import 'package:noa/screens/userScreens/HomePage.dart';
import 'package:noa/screens/userScreens/userProfile.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex =0;
  final screens = [
    HomePage(),
    UsersPlants(),
    UserProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //saving states of pages
      body: IndexedStack(
        children: screens,
        index: currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index)=>setState(()=>currentIndex=index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        selectedFontSize: 20,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(fontFamily: 'IndieFlower', fontWeight:FontWeight.bold,),
        items:[BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon(FontAwesomeIcons.home),
          ),
          label: 'Home',
          backgroundColor: Colors.green
        ),
          BottomNavigationBarItem(
              icon:Padding(
                padding: const EdgeInsets.all(3.0),
                child: Icon(FontAwesomeIcons.leaf),
              ),
              label: 'My plants',
              backgroundColor: Colors.green
          ),
          BottomNavigationBarItem(
              icon:Padding(
                padding: const EdgeInsets.all(3.0),
                child: Icon(FontAwesomeIcons.user),
              ),
              label: 'My profile',
              backgroundColor: Colors.green
          ),
        ],
      ),
    );
  }
}
