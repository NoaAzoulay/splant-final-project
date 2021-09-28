
import 'dart:async';

import 'package:noa/services/serverDataJson.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';
import 'package:noa/screens/userScreens/LandingPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:noa/screens/userScreens/splashScreen.dart';
import 'package:noa/services/Auth.dart';
import 'package:provider/provider.dart';
import 'package:eventsource/eventsource.dart';




void main() async{
  print('main');
  var eventSource =  await EventSource.connect("http://192.168.14.114/events");
  Future.delayed(Duration(seconds: 10),() {
    eventSource.where((e) => e.event == "status_readings").listen((event) {
      ServerDataJson().parseData(event.data);
    });
  });
 // eventSource.where((e) => e.event == "thresold_readings").listen((event) {print(event.data);});

  // eventSource.addEventListener("status_readings", (html.Event message) {
  //   print('status'+(message.toString()));
  //
  //
  // },
  // );
  // print('after');
  // eventSource.addEventListener("open", (html.Event message) {
  //   print((message as html.MessageEvent).data as String);
  // }
  // );
  // eventSource.addEventListener("soil_readings", (html.Event message) {
  //   print((message as html.MessageEvent).data as String);
  // }
  // );
  // eventSource.addEventListener("temperature_humidity_readings", (html.Event message) {
  //   print((message as html.MessageEvent).data as String);
  // }
  // );
  // eventSource.addEventListener("solar_readings", (html.Event message) {
  //   print((message as html.MessageEvent).data as String);
  // }
  // );
  // eventSource.addEventListener("thresold_readings", (html.Event message) {
  //   print((message as html.MessageEvent).data as String);
  // }
  // );
  // eventSource.addEventListener("status_readings", (html.Event message) {
  //   print((message as html.MessageEvent).data as String);
  // }
  // );


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










