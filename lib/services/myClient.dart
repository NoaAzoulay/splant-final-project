import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


 class MyClient  {

    MyClient._();
    static final instance =MyClient._();

    // String localhost = "192.168.14.114";
    // String path = "/myDIV_30";
    // HttpClient client = new HttpClient();
    // var response = client.getUrl(new Uri.http(localhost, path)).then((
    //     HttpClientRequest request) {
    //   return request.close();
    // });
    // print(response);

    void httpGetReqFromServer(String req) {
      String localhost = "192.168.14.114";
      HttpClient client = new HttpClient();
      var response = client.getUrl(new Uri.http(localhost, req)).then((
          HttpClientRequest request) {
        return request.close();
      });
      print(response);
    }

    void exHttpGetReqFromServer() {
      String localhost = "192.168.14.114";
      HttpClient client = new HttpClient();
      var response = client.getUrl(new Uri.http(localhost, "/myDIV_30")).then((
          HttpClientRequest request) {
        return request.close();
      });
      print(response);
    }
    //httpGetReqFromServer("/myDIV_31");

    void notifyServerFlowerBoxDeleted(String num) {
      switch (num) {
        case "1":
          httpGetReqFromServer("/myDIV_31");
          break;
        case "2":
          httpGetReqFromServer("/myDIV_33");
          break;
        case "3":
          httpGetReqFromServer("/myDIV_35");
          break;
        case "4":
          httpGetReqFromServer("/myDIV_37");
          break;
      }
    }
    void notifyServerFlowerBoxAdded(String num) {
      switch(num){
        case "1":
          String path= "/myDIV_30";
          httpGetReqFromServer(path);
          break;
        case "2":
          httpGetReqFromServer("/myDIV_32");
          break;
        case "3":
          httpGetReqFromServer("/myDIV_34");
          break;
        case "4":
          httpGetReqFromServer("/myDIV_36");
          break;
      }
    }

    void activateSprayerManually(){
      final String sprayerActive ="/myDIV_6";
      httpGetReqFromServer(sprayerActive);
    }

    void turnOffSprayerManually() {
      final String sprayerOff= "/myDIV_7";
      httpGetReqFromServer(sprayerOff);
    }

    void activateDripping(){
      final String activeDripping = "/myDIV_1";
      httpGetReqFromServer(activeDripping);
    }
    void turnOffDripping(){
      final String turnOffDripping="/myDIV_2";
      httpGetReqFromServer(turnOffDripping);
    }
  }


// listen for responses from the server
// socket.listen(
//
//   // handle data from the server
//       (Uint8List data) {
//     final serverResponse = String.fromCharCodes(data);
//     print('Server: $serverResponse');
//   },

// handle errors
//     onError: (error) {
//       print(error);
//       socket.destroy();
//     },
//
//     // handle server ending connection
//     onDone: () {
//       print('Server left.');
//       socket.destroy();
//     },
//   );
//
//   // send some messages to the server
//   await sendMessage(socket, 'Knock, knock.');
//   await sendMessage(socket, 'Banana');
//   await sendMessage(socket, 'Banana');
//   await sendMessage(socket, 'Banana');
//   await sendMessage(socket, 'Banana');
//   await sendMessage(socket, 'Banana');
//   await sendMessage(socket, 'Orange');
//   await sendMessage(socket, "Orange you glad I didn't say banana again?");
// }
//
// Future<void> sendMessage(Socket socket, String message) async {
//   print('Client: $message');
//   socket.write(message);
//   await Future.delayed(Duration(seconds: 2));

