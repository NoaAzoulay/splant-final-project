import 'package:flutter/material.dart';
import 'package:noa/screens/LandingPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:noa/services/Auth.dart';
import 'package:provider/provider.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Home());
}


class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {

  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
   // return FutureBuilder(
      // Initialize FlutterFire:
     // future: _initialization,
     // builder: (context, snapshot) {
        // Check for errors
       // if (snapshot.hasError) {
       //   return SomethingWentWrong();
       // }

        // Once complete, show your application
       // if (snapshot.connectionState == ConnectionState.done) {
          return Provider<AuthBase>(
            create: (context)=>Auth(),
            child: MaterialApp(
              theme: ThemeData(
                primaryColor: Colors.green[100],
              ),
              home: LandingPage(

              ),
// body: Center(
//   child: Image(
//    // image: AssetImage('assets/sea1.jpg'),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
       // return Loading();
    //  },
   // );
 // }
}










