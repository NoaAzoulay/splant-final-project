

#include <Arduino.h>
#include <WiFi.h>
#include <AsyncTCP.h>
#include <ESPAsyncWebServer.h>
#include <Arduino_JSON.h>
#include "SPIFFS.h"
#include <Adafruit_SI1145.h> //[I2C SENSOR UV SENSOR]
#include <Adafruit_Sensor.h>
#include <DHT.h> //[TEMP&HUMIDITY SENSOR]
#include <DHT_U.h>
#include <Wire.h>
 
 
 

// Replace with your network credentials
    const char* ssid = "JENNY12";
    const char* password = "24071960";

//====================================================
//#define I2C_SDA 21
//#define I2C_SCL 22
#define DHTPIN 14     // Digital pin connected to the DHT sensor (ADDITION TO +5v OR +3.3v ,gnd)
const int sensorPin1 = 34;// Analog pin-  [PIN SOIL HUMIDITY 1 SENSOR IS ATTACHED]
const int sensorPin2 =35;// Analog pin-  [PIN SOIL HUMIDITY 2 SENSOR IS ATTACHED]
const int sensorPin3 = 32;// Analog pin-  [PIN SOIL HUMIDITY 3 SENSOR IS ATTACHED]
const int sensorPin4 = 33;// Analog pin-  [PIN SOIL HUMIDITY 4 SENSOR IS ATTACHED]

int RELAY_1 = 42; //DEFINITION OF RELAY 1 ACTING ELECTRIC WATER VALVE FOR PANEL 1&2
int RELAY_2 = 27; // DEFINITION OF RELAY 2 LIFTING PARASOL 
int RELAY_4 = 12; // DEFINITION OF RELAY 4 DOWNING PARASOL
int RELAY_5 = 13;// DEFINITION OF RELAY 5 ACTING ELECTRIC WATER VALVE FOR PANEL 3&4
int flag_panel_12_on = 2;int flag_panel_34_on = 2;int flag_sprayer_on=2;int flag_box1_on=2;int flag_box2_on=2;int flag_box3_on=2;int flag_box4_on=2;
int fpc_sprayer=0;int fpc_box1=0 ;int fpc_box2=0 ;int fpc_box3=0 ;int fpc_box4=0 ;
int fpc12=0;int fpc34=0; int flag_box1_30=0;int flag_box1_50=0;int flag_box1_70=0;int duration;
int flag_box2_30=0;int flag_box2_50=0;int flag_box2_70=0;
int flag_box3_30=0;int flag_box3_50=0;int flag_box3_70=0;
int flag_box4_30=0;int flag_box4_50=0;int flag_box4_70=0;
//================================================================================================

 float Soil_Humidity1=0.; // RAW SOIL HUMIDITY SENSOR 1 MEASURMENT AFTER ANALOG TO DIGITAL SAMPLING
 float Soil_Humidity2=0.; // RAW SOIL HUMIDITY SENSOR 2 MEASURMENT AFTER ANALOG TO DIGITAL SAMPLING
 float Soil_Humidity3=0.; // RAW SOIL HUMIDITY SENSOR 3 MEASURMENT AFTER ANALOG TO DIGITAL SAMPLING
 float Soil_Humidity4=0.; // RAW SOIL HUMIDITY SENSOR 4 MEASURMENT AFTER ANALOG TO DIGITAL SAMPLING
 float Soil_Humidity_1=0.; // percentage of SOIL HUMIDITY SENSOR 1 MEASURMENT AFTER ANALOG TO DIGITAL SAMPLING
 float Soil_Humidity_2 =0.; // percentage of SOIL SOIL HUMIDITY SENSOR 2 MEASURMENT AFTER ANALOG TO DIGITAL SAMPLING
 float Soil_Humidity_3 =0.; // percentage of SOIL SOIL HUMIDITY SENSOR 3 MEASURMENT AFTER ANALOG TO DIGITAL SAMPLING
 float Soil_Humidity_4 =0.; // percentage of SOIL SOIL HUMIDITY SENSOR 4 MEASURMENT AFTER ANALOG TO DIGITAL SAMPLING
 float Soil_Humidity_ave1 =0.; // percentage of SOIL SOIL HUMIDITY SENSOR 4 MEASURMENT AFTER ANALOG TO DIGITAL SAMPLING
 float Soil_Humidity_ave2 =0.; // percentage of SOIL SOIL HUMIDITY SENSOR 4 MEASURMENT AFTER ANALOG TO DIGITAL SAMPLING
 float MY_TEMPERATURE=0.;// EXTERNAL TEMPERATURE MEASURMENT PARAMETER AFTER SAMPLING DHT11
 float MY_HUMIDITY=0.; // EXTERNAL HUMIDITY MEASURMENT PARAMETER AFTER SAMPLING DHT11
 float UVindex=0.;
 float thresold_1=0.;
 float thresold_2=0.;
 float thresold_3=0.;
 float thresold_4=0.;
//=================================================

String  AUTOVALVE_PANEL_STATUS="On";
String  CONTROLVALVE_PANEL_STATUS="Off";
String  SPRAYER_STATUS="Off";
String  SOLAR_INTENSITY="LOW";
//=====================initialize box add/remove status=======================================
String  BOX1_STATUS ="Off";
String  BOX2_STATUS ="Off";
String  BOX3_STATUS ="Off";
String  BOX4_STATUS ="Off";
//=================================thresold reading  status ===================================================
 String  BOX1_THRESOLD_ACTIVE="0%";
 String  BOX2_THRESOLD_ACTIVE="0%";
 String  BOX3_THRESOLD_ACTIVE="0%";
 String  BOX4_THRESOLD_ACTIVE="0%";

 
 #define DHTTYPE    DHT11     // DHT 11
 uint32_t delayMS;
 DHT_Unified dht(DHTPIN, DHTTYPE);
//=================================================
// Define object uv
Adafruit_SI1145 uv = Adafruit_SI1145();
//=================================================
// Create AsyncWebServer object on port 80
AsyncWebServer server(80);

// Create an Event Source on /events
AsyncEventSource events("/events");

// Json Variable to Hold Sensor Readings
JSONVar readings;

// Timer variables
unsigned long lastTime = 0;  
unsigned long lastTimeTemp_Hum = 0;
unsigned long lastTimeSoil = 0;
unsigned long lastTimeUv = 0;
unsigned long lastTimeStatus = 0;
unsigned long lastTimeThresold = 0;
unsigned long temp_humDelay = 200;
unsigned long soilDelay = 300;
unsigned long uvDelay = 200;
unsigned long statusDelay = 50;
unsigned long currentMillis_status_contol_panel12 ;
unsigned long previousMillis_status_contol_panel12=0 ;
unsigned long delay_p12 = 190000;
unsigned long currentMillis_sprayer ;
unsigned long previousMillis_sprayer=0 ;
unsigned long currentMillis_box1 ;
unsigned long previousMillis_box1=0 ;
unsigned long currentMillis_box2 ;
unsigned long previousMillis_box2=0 ;
unsigned long currentMillis_box3 ;
unsigned long previousMillis_box3=0 ;
unsigned long currentMillis_box4 ;
unsigned long previousMillis_box4=0 ;
long unsigned previousMillis=0;
unsigned long delay_SP =  120000;
unsigned long lastTimeSeting;
unsigned long setimeDelay = 100;
unsigned long SETIME_12=0;
unsigned long SETIME_SP=0;

 



void initSPIFFS() {
  if (!SPIFFS.begin()) {
    Serial.println("An error has occurred while mounting SPIFFS");
  }
  Serial.println("SPIFFS mounted successfully");
}

// Initialize WiFi
void initWiFi() {
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  Serial.println("");
  Serial.print("Connecting to WiFi...");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(1000);
  }
  Serial.println("");
  Serial.println(WiFi.localIP());
}


String soil_readings() {

//  ============================ SAMPLING&REPORT OF SOIL HUMIDITY OF EACH PLATE============================================
Soil_Humidity1 = 1.*analogRead(sensorPin1);delay(2); Soil_Humidity1=-0.03846*Soil_Humidity1+134.6154;if(Soil_Humidity1<0){Soil_Humidity1=0.0;}
 
Soil_Humidity2 = 1.*analogRead(sensorPin2);delay(2); Soil_Humidity2=-0.03846*Soil_Humidity2+134.6154;if(Soil_Humidity2<0){Soil_Humidity2=0.0;}
 
Soil_Humidity3 = 1.*analogRead(sensorPin3);delay(2); Soil_Humidity3=-0.03846*Soil_Humidity3+134.6154;if(Soil_Humidity3<0){Soil_Humidity3=0.0;}
 
Soil_Humidity4 = 1.*analogRead(sensorPin4);delay(2); Soil_Humidity4=-0.03846*Soil_Humidity4+134.6154;if(Soil_Humidity4<0){Soil_Humidity4=0.0;}
  //====================================================================

   
  readings["Soil_Humidity1"] = String(Soil_Humidity1);
  readings["Soil_Humidity2"] = String(Soil_Humidity2);
  readings["Soil_Humidity3"] = String(Soil_Humidity3);
  readings["Soil_Humidity4"] = String(Soil_Humidity4);
  String soil_readings = JSON.stringify (readings);
  return soil_readings;
}
//======================================================================================
 
String temperature_humidity_readings() {
 
 // Get EXTERNAL temperature event and print its value.
  sensors_event_t event;
  dht.temperature().getEvent(&event);
   
  if (isnan(event.temperature)) {
    Serial.println(F("Error reading temperature!"));
  }
  else {
    MY_TEMPERATURE= event.temperature;  //Serial.print("External Temperature:");Serial.println(MY_TEMPERATURE);

  
  // Get EXTERNAL humidity event and print its value.
  dht.humidity().getEvent(&event);
  if (isnan(event.relative_humidity)) {
    Serial.println(F("Error reading humidity!"));
  }
  else {
      MY_HUMIDITY= event.relative_humidity; // Serial.print("External Humidity:"); Serial.println(MY_HUMIDITY);
      }
        
 }
 
 //======================================================================================
 
  readings["MY_TEMPERATURE"] = String(MY_TEMPERATURE);
  readings["MY_HUMIDITY"] = String(MY_HUMIDITY);
 
  String temperature_humidity_readings = JSON.stringify (readings);
  return temperature_humidity_readings;
}
//==============================================================================================
String solar_readings() {
// Read UV level
   UVindex = uv.readUV();
  // Divide by 100 for UV index
  UVindex /= 100.0; 
   //========================REPORTING  TYPE OF UV INDEX (LOW,HIGH,MEDIUM)=========================
  if (UVindex < 3.0) 
  {
    SOLAR_INTENSITY="LOW";
  }
   else if (UVindex >= 3 && UVindex < 6) 
  {
    SOLAR_INTENSITY= "MEDIUM"; 
  } 
   else if (UVindex >= 6 && UVindex < 8) 
  {
    SOLAR_INTENSITY="HIGH"; 
  } 
   else
  {
   SOLAR_INTENSITY="VERY HIGH";  
  } 


  readings["UVindex"] = String(UVindex);
  readings["SOLAR_INTENSITY"] = String(SOLAR_INTENSITY);
 
  String solar_readings = JSON.stringify (readings);
  return solar_readings;
}


//=============================================================================================================
String status_readings() {
   readings["SPRAYER_STATUS"] = String(SPRAYER_STATUS);
   readings["AUTOVALVE_PANEL_STATUS"] = String(AUTOVALVE_PANEL_STATUS);

   readings["SETIME_12"] = String(SETIME_12);

   readings["SETIME_SP"] = String(SETIME_SP);
   readings["BOX1_STATUS"] = String(BOX1_STATUS);
    readings["BOX2_STATUS"] = String(BOX2_STATUS);
    readings["BOX3_STATUS"] = String(BOX3_STATUS);
    readings["BOX4_STATUS"] = String(BOX4_STATUS);
   readings["BOX1_THRESOLD_ACTIVE"] = String(thresold_1);
   readings["BOX2_THRESOLD_ACTIVE"] = String(thresold_2);
   readings["BOX3_THRESOLD_ACTIVE"] = String(thresold_3);
   readings["BOX4_THRESOLD_ACTIVE"] = String(thresold_4);
 
  String status_readings = JSON.stringify (readings);
  return status_readings;
}

 


//========================================================================
void setup() {
  Serial.begin(115200);
  initWiFi();
  initSPIFFS();
  while(!Serial) {}

     dht.begin(); 
  // Print temperature sensor details.
  sensor_t sensor;
  dht.temperature().getSensor(&sensor);

  // Print humidity sensor details.
  dht.humidity().getSensor(&sensor);

  
  // Initialize UV sensor
  uv.begin();
 
//   Serial.println("ok");//CHECK OF SERIAL CONNECTION
  pinMode(RELAY_1,OUTPUT);//PINMODE DEFINITION OF RELAY 1
  pinMode(RELAY_2,OUTPUT);//PINMODE DEFINITION OF RELAY 2  
  
  pinMode(RELAY_4,OUTPUT);//PINMODE DEFINITION OF RELAY 4
  pinMode(RELAY_5,OUTPUT);//PINMODE DEFINITION OF RELAY 5
    
   digitalWrite(RELAY_2,HIGH);digitalWrite(RELAY_4,HIGH);digitalWrite(RELAY_4,HIGH);
   digitalWrite(RELAY_1,HIGH);digitalWrite(RELAY_5,HIGH); 
 // Handle Web Server
 //========================================activate dripping==================================================
  server.on("/", HTTP_GET, [](AsyncWebServerRequest *request){
    request->send(SPIFFS, "/index.html", "text/html");
  });

  server.serveStatic("/", SPIFFS, "/");

  server.on("/myDIV_1", HTTP_GET, [](AsyncWebServerRequest *request){
   
      flag_panel_12_on = 0;currentMillis_status_contol_panel12=millis(); 
    if(fpc12<1){fpc12=2; previousMillis_status_contol_panel12= millis() ;}
    request->send(200, "text/plain", "OK");
  });

  //======================================turn off dripping===============================================
  
    server.on("/myDIV_2", HTTP_GET, [](AsyncWebServerRequest *request){
   
      flag_panel_12_on=2;SETIME_12=0;fpc12=0;AUTOVALVE_PANEL_STATUS="Off";
    request->send(200, "text/plain", "OK");
  });
//treshold
  server.serveStatic("/", SPIFFS, "/");
 server.on("/myDIV_3", HTTP_GET, [](AsyncWebServerRequest *request){
   
       flag_box1_30=1;flag_box1_50=0;flag_box1_70=0;thresold_1=30;
       request->send(200, "text/plain", "OK");
  });

  server.on("/myDIV_4", HTTP_GET, [](AsyncWebServerRequest *request){
   
       flag_box1_30=0;flag_box1_50=1;flag_box1_70=0;thresold_1=50;
       request->send(200, "text/plain", "OK");
  });

  server.on("/myDIV_5", HTTP_GET, [](AsyncWebServerRequest *request){
   
       flag_box1_30=0;flag_box1_50=0;flag_box1_70=1;thresold_1=70;
       request->send(200, "text/plain", "OK");
  });
//============================================================================================
//=========================================BOX2=============================================================
  server.serveStatic("/", SPIFFS, "/");
 server.on("/myDIV_13", HTTP_GET, [](AsyncWebServerRequest *request){
   
       flag_box2_30=1;flag_box2_50=0;flag_box2_70=0;thresold_2=30;
       request->send(200, "text/plain", "OK");
  });

  server.on("/myDIV_14", HTTP_GET, [](AsyncWebServerRequest *request){
   
       flag_box2_30=0;flag_box2_50=1;flag_box2_70=0;thresold_2=50;
       request->send(200, "text/plain", "OK");
  });

  server.on("/myDIV_15", HTTP_GET, [](AsyncWebServerRequest *request){
   
       flag_box2_30=0;flag_box2_50=0;flag_box2_70=1;thresold_2=70;
       request->send(200, "text/plain", "OK");
  });
//============================================================================================
//=========================================BOX3=============================================================
  server.serveStatic("/", SPIFFS, "/");
 server.on("/myDIV_23", HTTP_GET, [](AsyncWebServerRequest *request){
   
       flag_box3_30=1;flag_box3_50=0;flag_box3_70=0;thresold_3=30;
       request->send(200, "text/plain", "OK");
  });

  server.on("/myDIV_24", HTTP_GET, [](AsyncWebServerRequest *request){
   
       flag_box3_30=0;flag_box3_50=1;flag_box3_70=0;thresold_2=50;
       request->send(200, "text/plain", "OK");
  });

  server.on("/myDIV_25", HTTP_GET, [](AsyncWebServerRequest *request){
   
       flag_box3_30=0;flag_box3_50=0;flag_box3_70=1;thresold_2=70;
       request->send(200, "text/plain", "OK");
  });
//============================================================================================
//=========================================BOX4=============================================================
  server.serveStatic("/", SPIFFS, "/");
 server.on("/myDIV_43", HTTP_GET, [](AsyncWebServerRequest *request){
   
       flag_box4_30=1;flag_box4_50=0;flag_box4_70=0;thresold_4=30;
       request->send(200, "text/plain", "OK");
  });

  server.on("/myDIV_44", HTTP_GET, [](AsyncWebServerRequest *request){
   
       flag_box4_30=0;flag_box4_50=1;flag_box4_70=0;thresold_4=50;
       request->send(200, "text/plain", "OK");
  });

  server.on("/myDIV_45", HTTP_GET, [](AsyncWebServerRequest *request){
   
       flag_box4_30=0;flag_box4_50=0;flag_box4_70=1;thresold_4=70;
       request->send(200, "text/plain", "OK");
  });
//============================================================================================
//========================================sprayer======================================================


  server.serveStatic("/", SPIFFS, "/"); 
  server.on("/myDIV_6", HTTP_GET, [](AsyncWebServerRequest *request){
   flag_sprayer_on=0;currentMillis_sprayer=millis();
   if(fpc_sprayer<1){fpc_sprayer=2; previousMillis_sprayer= currentMillis_sprayer ;} 
    request->send(200, "text/plain", "OK");
  });
  
//=======================================sprayer============================================================
  server.on("/myDIV_7", HTTP_GET, [](AsyncWebServerRequest *request){
   flag_sprayer_on=2;SETIME_SP=0; fpc_sprayer=0;SPRAYER_STATUS="Off";
    request->send(200, "text/plain", "OK");
  });

  //========================================BOX1 add======================================================
  server.serveStatic("/", SPIFFS, "/"); 
  server.on("/myDIV_30", HTTP_GET, [](AsyncWebServerRequest *request){
   flag_box1_on=0;currentMillis_box1=millis();  BOX1_STATUS="On";
   if(fpc_box1<1){fpc_box1=2; previousMillis_box1= currentMillis_box1 ;} 
    request->send(200, "text/plain", "OK");
  });
  
//=======================================BOX1 remove ============================================================
  server.on("/myDIV_31", HTTP_GET, [](AsyncWebServerRequest *request){
   flag_box1_on=2;  fpc_box1=0;BOX1_STATUS="Off";
    request->send(200, "text/plain", "OK");
  });
  //========================================BOX2 add======================================================
  server.serveStatic("/", SPIFFS, "/"); 
  server.on("/myDIV_32", HTTP_GET, [](AsyncWebServerRequest *request){
   flag_box2_on=0;currentMillis_box2=millis();BOX2_STATUS="On";
   if(fpc_box2<1){fpc_box2=2; previousMillis_box2= currentMillis_box2 ;} 
    request->send(200, "text/plain", "OK");
  });
  
//=======================================BOX2 remove ============================================================
  server.on("/myDIV_33", HTTP_GET, [](AsyncWebServerRequest *request){
   flag_box2_on=2;  fpc_box2=0;BOX2_STATUS="Off";
    request->send(200, "text/plain", "OK");
  });
  //========================================BOX3 add======================================================
  server.serveStatic("/", SPIFFS, "/"); 
  server.on("/myDIV_34", HTTP_GET, [](AsyncWebServerRequest *request){
   flag_box3_on=0;currentMillis_box3=millis();BOX3_STATUS="On";
   if(fpc_box3<1){fpc_box3=2; previousMillis_box3= currentMillis_box3 ;} 
    request->send(200, "text/plain", "OK");
  });
  
//=======================================BOX3 remove ============================================================
  server.on("/myDIV_35", HTTP_GET, [](AsyncWebServerRequest *request){
   flag_box3_on=2;  fpc_box3=0;BOX3_STATUS="Off";
    request->send(200, "text/plain", "OK");
  });
  //========================================BOX4 add======================================================
  server.serveStatic("/", SPIFFS, "/"); 
  server.on("/myDIV_36", HTTP_GET, [](AsyncWebServerRequest *request){
   flag_box4_on=0;currentMillis_box4=millis();BOX4_STATUS="On";
   if(fpc_box4<1){fpc_box4=2; previousMillis_box4= currentMillis_box4 ;} 
    request->send(200, "text/plain", "OK");
  });
  
//=======================================BOX4 remove ============================================================
  server.on("/myDIV_37", HTTP_GET, [](AsyncWebServerRequest *request){
   flag_box4_on=2;  fpc_box4=0;BOX4_STATUS="Off";
    request->send(200, "text/plain", "OK");
  });

//===================================================================================================
  // Handle Web Server Events
  events.onConnect([](AsyncEventSourceClient *client){
    if(client->lastId()){
      Serial.printf("Client reconnected! Last message ID that it got is: %u\n", client->lastId());
    }
    // send event with message "hello!", id current millis
    // and set reconnect delay to 1 second
    client->send("hello!", NULL, millis(), 10000);
  });
  server.addHandler(&events);
  server.begin();
}

void loop() {

  if(flag_box1_on>1){thresold_1=0.;}
   if(flag_box2_on>1){thresold_2=0.;}
     if(flag_box3_on>1){thresold_3=0.;}
       if(flag_box4_on>1){thresold_4=0.;}



  if ((millis() - lastTimeSoil) > soilDelay) {
    // Send Events to the Web Server with the Sensor Readings
    events.send(soil_readings().c_str(),"soil_readings",millis());
    lastTimeSoil = millis();
  }
  if ((millis() - lastTimeTemp_Hum) > temp_humDelay) {
    // Send Events to the Web Server with the Sensor Readings
    events.send(temperature_humidity_readings().c_str(),"temperature_humidity_readings",millis());
    lastTimeTemp_Hum = millis(); 
  }
  if ((millis() - lastTimeUv) > uvDelay) {
    // Send Events to the Web Server with the Sensor Readings
    events.send(solar_readings().c_str(),"solar_readings",millis());
    lastTimeUv = millis();
  }
  if ((millis() - lastTimeStatus) > statusDelay) {
    // Send Events to the Web Server with the Sensor Readings
    events.send(status_readings().c_str(),"status_readings",millis());
    lastTimeStatus = millis();
  }

//=======================COMPUTING&REPORT OF AVERAGE SOIL HUMIDITY========================================================
Soil_Humidity1 = 1.*analogRead(sensorPin1);delay(2); Soil_Humidity1=-0.03846*Soil_Humidity1+174.6154;if(Soil_Humidity1<0){Soil_Humidity1=0.0;}
 
Soil_Humidity2 = 1.*analogRead(sensorPin2);delay(2); Soil_Humidity2=-0.03846*Soil_Humidity2+134.6154;if(Soil_Humidity2<0){Soil_Humidity2=0.0;}
 
Soil_Humidity3 = 1.*analogRead(sensorPin3);delay(2);  Soil_Humidity3=-0.03846*Soil_Humidity3+134.6154;if(Soil_Humidity3<0){Soil_Humidity3=0.0;}
Soil_Humidity4 = 1.*analogRead(sensorPin4);delay(2);  Soil_Humidity4=-0.03846*Soil_Humidity3+134.6154;if(Soil_Humidity4<0){Soil_Humidity4=0.0;}
 
if(Soil_Humidity1<=thresold_1){digitalWrite(RELAY_1,LOW);AUTOVALVE_PANEL_STATUS="AUTOMATIC DRIPPING:ON";}
if(Soil_Humidity1>thresold_1){digitalWrite(RELAY_1,HIGH);delay(1000);AUTOVALVE_PANEL_STATUS="AUTOMATIC DRIPPING:OFF";}
if(Soil_Humidity2<=thresold_2){digitalWrite(RELAY_1,LOW);AUTOVALVE_PANEL_STATUS="AUTOMATIC DRIPPING:ON";}
if(Soil_Humidity2>thresold_2){digitalWrite(RELAY_1,HIGH);delay(1000);AUTOVALVE_PANEL_STATUS="AUTOMATIC DRIPPING:OFF";}
if(Soil_Humidity3<=thresold_3){digitalWrite(RELAY_1,LOW);AUTOVALVE_PANEL_STATUS="AUTOMATIC DRIPPING:ON";}
if(Soil_Humidity3>thresold_3){digitalWrite(RELAY_1,HIGH);delay(1000);AUTOVALVE_PANEL_STATUS="AUTOMATIC DRIPPING:OFF";}
if(Soil_Humidity4<=thresold_4){digitalWrite(RELAY_1,LOW);AUTOVALVE_PANEL_STATUS="AUTOMATIC DRIPPING:ON";}
if(Soil_Humidity4>thresold_4){digitalWrite(RELAY_1,HIGH);delay(1000);AUTOVALVE_PANEL_STATUS="AUTOMATIC DRIPPING:OFF";}


 

  
 
//==================================================================================================================
 
 
//=============================END OF SELF AUTOMATION =============================================================== 
 
if(flag_panel_12_on<1){currentMillis_status_contol_panel12=millis(); 
  if((currentMillis_status_contol_panel12-previousMillis_status_contol_panel12)<delay_p12){
      digitalWrite(RELAY_1,LOW);AUTOVALVE_PANEL_STATUS="Forced On";SETIME_12=(currentMillis_status_contol_panel12-previousMillis_status_contol_panel12)/1000;}
  if((currentMillis_status_contol_panel12-previousMillis_status_contol_panel12)>=delay_p12){SETIME_12=0;
      digitalWrite(RELAY_1,HIGH);delay(1000);AUTOVALVE_PANEL_STATUS="Return Normal";delay(2000);flag_panel_12_on=2;
      fpc12=0; }}

if(flag_sprayer_on<1){currentMillis_sprayer=millis(); 
  if((currentMillis_sprayer-previousMillis_sprayer)<delay_SP){
      digitalWrite(RELAY_4,LOW);SPRAYER_STATUS="On";SETIME_SP=(currentMillis_sprayer-previousMillis_sprayer)/1000;}
  if((currentMillis_sprayer-previousMillis_sprayer)>=delay_SP){SETIME_SP=0;
      digitalWrite(RELAY_4,HIGH);delay(1000);SPRAYER_STATUS="Off";delay(2000);flag_sprayer_on=2;fpc_sprayer=0; }}

   
  if(flag_panel_12_on>0)  {
                         if(Soil_Humidity1>30.){ delay(350);digitalWrite(RELAY_1,HIGH);AUTOVALVE_PANEL_STATUS="Off";  }                     
                         if((Soil_Humidity1<=30.)&&(Soil_Humidity1>0.)) {delay(350);digitalWrite(RELAY_1,LOW);AUTOVALVE_PANEL_STATUS="On"; }
                         if(Soil_Humidity2>30.){ delay(350);digitalWrite(RELAY_1,HIGH);AUTOVALVE_PANEL_STATUS="Off";  }                     
                         if((Soil_Humidity2<=30.)&&(Soil_Humidity2>0.)) {delay(350);digitalWrite(RELAY_1,LOW);AUTOVALVE_PANEL_STATUS="On"; }
                         if(Soil_Humidity3>30.){ delay(350);digitalWrite(RELAY_1,HIGH);AUTOVALVE_PANEL_STATUS="Off";  }                     
                         if((Soil_Humidity3<=30.)&&(Soil_Humidity3>0.)) {delay(350);digitalWrite(RELAY_1,LOW);AUTOVALVE_PANEL_STATUS="On"; }
                         if(Soil_Humidity4>30.){ delay(350);digitalWrite(RELAY_1,HIGH);AUTOVALVE_PANEL_STATUS="Off";  }                     
                         if((Soil_Humidity4<=30.)&&(Soil_Humidity4>0.)) {delay(350);digitalWrite(RELAY_1,LOW);AUTOVALVE_PANEL_STATUS="On"; }
                          }
          
  if(flag_sprayer_on>0){digitalWrite(RELAY_4,HIGH);delay(1000);SPRAYER_STATUS="Off";}
 
}
