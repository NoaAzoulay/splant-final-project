import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noa/services/serverDataJson.dart';
import 'package:noa/services/myClient.dart';
import 'package:universal_html/html.dart' as html;
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  MyClient client = MyClient.instance;

  //final  Future<String> data=ServerDataJson().getHtmlasync() ;

  @override
  Widget build(BuildContext context) {
    // var eventSource = new html.EventSource("http://192.168.14.114/events");
    // eventSource.addEventListener('status_readings', (html.Event message) {
    //   print('status'+(message as html.MessageEvent).data as String);
    // },
    // );
    //ServerDataJson().getHtmlasync();
    return Scaffold(
      // body:Text(ServerDataJson().getHtmlasync()),
      // FutureBuilder<String>(
      //       future: ServerDataJson().getHtmlasync(),
      //       builder: (context, snapshot) {
      //         if (snapshot.hasData) {
      //           return show();
      //         }
      //         if(!snapshot.hasData){
      //           print('no data');
      //         }
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //   ),
      );


    //   SingleChildScrollView(
    //   child: Container(
    //     child: TextButton(
    //       onPressed:()=> letsGo(),
    //       child: Text('spray'),
    //     ),
    //   ),
    // );
  }

//   GridView show() {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 1,
//       ),
//       itemCount: data,
//       itemBuilder: (context, i) {
//         return Text(
//           (data),
//         );
//       },
//     );
//   }
 }

// void letsGo() {
//   client.httpGetReqFromServer("/myDIV_30");
// }
// client.activateSprayerManually();
//   var eventSource = new html.EventSource("/events");
//   eventSource.addEventListener('open', (html.Event message) {
//     print((message as html.MessageEvent).data as String);
//   });
//     eventSource.addEventListener('status_readings', (html.Event message) {
//       print((message as html.MessageEvent).data as String);
//   });
//   client.turnOffDripping();
// }
