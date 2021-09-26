
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';
import 'package:noa/screens/userScreens/LandingPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:noa/screens/userScreens/splashScreen.dart';
import 'package:noa/services/Auth.dart';
import 'package:provider/provider.dart';




void main() async{
  var eventSource = new html.EventSource("http://192.168.14.114/events");
  eventSource.addEventListener('status_readings', (html.Event message) {
    print((message as html.MessageEvent).data as String);
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










