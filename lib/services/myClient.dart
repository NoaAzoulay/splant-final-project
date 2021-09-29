import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noa/models/plant.dart';



 class MyClient {
   Plant plant;
   User currentUser = FirebaseAuth.instance.currentUser;
   CollectionReference users = FirebaseFirestore.instance.collection('users');
   final  String localhost = "192.168.14.114";

//singleton
    MyClient._();
    static final instance =MyClient._();

    void httpGetReqFromServer(String req) {
      HttpClient client = new HttpClient();
      var response = client.getUrl(new Uri.http(localhost, req)).then((
          HttpClientRequest request) {
        return request.close();
      });
      print(response);
    }


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
   Future<void> updateThreshold(Plant plant, int num) async {
     try {
       users.doc(currentUser.uid).collection("plants").doc(plant.id).update({
         'threshold' : num
       }). then((value) => print(num));
     }on FirebaseException catch (e) {
       print(e);
     }
   }



    void notifyServerFlowerBoxAdded(String num, Plant plant) {
      switch(num){
        case "1":
         httpGetReqFromServer("/myDIV_30");
         Future.delayed(Duration(seconds: 5),() {
           thresholdCheckForBox1(plant);
         });
          break;
        case "2":
         httpGetReqFromServer("/myDIV_32");
         Future.delayed(Duration(seconds: 5),(){
           thresholdCheckForBox2(plant);
         });
          break;
        case "3":
          httpGetReqFromServer("/myDIV_34");
          Future.delayed(Duration(seconds: 5),() {
            thresholdCheckForBox3(plant);
          });
          break;
        case "4":
          httpGetReqFromServer("/myDIV_36");
          Future.delayed(Duration(seconds: 5),() {
          thresholdCheckForBox4(plant);
          });
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
    void setTreshold30ForBox1(){
      httpGetReqFromServer("/myDIV_3");
    }
    void setTreshold50ForBox1(){
      httpGetReqFromServer("/myDIV_4");
    }
    void setTreshold70ForBox1(){
      httpGetReqFromServer("/myDIV_5");
    }
    void setTreshold30ForBox2(){
      httpGetReqFromServer("/myDIV_13");
    }
    void setTreshold50ForBox2(){
      httpGetReqFromServer("/myDIV_14");
    }
    void setTreshold70ForBox2(){
      httpGetReqFromServer("/myDIV_15");
    }
    void setTreshold30ForBox3(){
      httpGetReqFromServer("/myDIV_23");
    }
    void setTreshold50ForBox3(){
      httpGetReqFromServer("/myDIV_24");
    }
    void setTreshold70ForBox3(){
      httpGetReqFromServer("/myDIV_25");
    }
    void setTreshold30ForBox4(){
      httpGetReqFromServer("/myDIV_43");
    }
    void setTreshold50ForBox4(){
      httpGetReqFromServer("/myDIV_44");
    }
    void setTreshold70ForBox4(){
      httpGetReqFromServer("/myDIV_45");
    }

   void thresholdCheckForBox1(Plant plant){
     if(plant.soilHumidity>70){
       setTreshold70ForBox1();
       updateThreshold(plant,70);
     }if(((plant.soilHumidity)>29)&&((plant.soilHumidity)<71)){
       setTreshold50ForBox1();
       updateThreshold(plant, 50);
     }else{
       setTreshold30ForBox1();
       updateThreshold(plant, 30);
     }
   }
   void thresholdCheckForBox2(plant){
     if (plant.soilHumidity > 70) {
       setTreshold70ForBox2();
       updateThreshold(plant, 70);
     } else if ((plant.soilHumidity > 29) && (plant.soilHumidity < 71)) {
       setTreshold50ForBox2();
       updateThreshold(plant, 50);
     } else {
       setTreshold30ForBox2();
       updateThreshold(plant, 30);
     }}

   void thresholdCheckForBox3(plant){
     if (plant.soilHumidity > 70) {
       setTreshold70ForBox3();
       updateThreshold(plant, 70);
     } else if ((plant.soilHumidity > 29) && (plant.soilHumidity < 71)) {
       setTreshold50ForBox3();
       updateThreshold(plant, 50);
     } else {
       setTreshold30ForBox3();
       updateThreshold(plant, 30);
     }
   }
   void thresholdCheckForBox4(plant){
     if(plant.soilHumidity>69){
       setTreshold70ForBox4();
       updateThreshold(plant, 70);
     }else if((plant.soilHumidity>29)&&(plant.soilHumidity<71)){
       setTreshold50ForBox4();
       updateThreshold(plant, 50);
     }else{
       setTreshold30ForBox4();
       updateThreshold(plant, 30);
     }

   }

  }


