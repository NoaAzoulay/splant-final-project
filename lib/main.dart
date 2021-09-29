import 'dart:async';
import 'package:noa/services/serverDataJson.dart';
import 'package:flutter/material.dart';
import 'package:noa/screens/userScreens/LandingPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:noa/screens/userScreens/splashScreen.dart';
import 'package:noa/services/Auth.dart';
import 'package:provider/provider.dart';
import 'package:eventsource/eventsource.dart';



void main() async{
  print('main');
  var eventSource =  await EventSource.connect("http://192.168.14.34/events");
  Future.delayed(Duration(seconds: 10),() {
    eventSource.where((e) => e.event == "status_readings").listen((event) {
      ServerDataJson().parseData(event.data);
    });
  });
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Home());
}


class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
          return Provider<AuthBase>(
            create: (context)=>Auth(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: Colors.green[100],
              ),
              home: SplashPage(
                duration: 3,
                goToPage: LandingPage(),
              ),
            ),
          );
        }

}










