import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noa/services/myClient.dart';
import 'package:universal_html/html.dart' as html;

class HomePage extends StatelessWidget {
  MyClient client= MyClient.instance ;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: TextButton(
          onPressed:()=> letsGo(),
          child: Text('spray'),
        ),
      ),
    );
  }

  void letsGo() {
   // client.activateSprayerManually();
    var eventSource = new html.EventSource("/events");
    eventSource.addEventListener('open', (html.Event message) {
      print((message as html.MessageEvent).data as String);
    });
      eventSource.addEventListener('status_readings', (html.Event message) {
        print((message as html.MessageEvent).data as String);
    });
    client.turnOffDripping();
  }
}
