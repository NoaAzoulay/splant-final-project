


// Create events for the sensor readings
if (!!window.EventSource) {
  var source = new EventSource('/events');

  source.addEventListener('open', function(e) {
    console.log("Events Connected");
  }, false);

  source.addEventListener('error', function(e) {
    if (e.target.readyState != EventSource.OPEN) {
      console.log("Events Disconnected");
    }
  }, false);


  source.addEventListener('soil_readings', function(e) {
    console.log("soil_readings", e.data);
    var obj = JSON.parse(e.data);
    document.getElementById("Soil_Humidity1").innerHTML = obj.Soil_Humidity1;
    document.getElementById("Soil_Humidity2").innerHTML = obj.Soil_Humidity2;
    document.getElementById("Soil_Humidity3").innerHTML = obj.Soil_Humidity3;
    document.getElementById("Soil_Humidity4").innerHTML = obj.Soil_Humidity4;


  }, false);

  source.addEventListener('temperature_humidity_readings', function(e) {
    console.log("temperature_humidity_readings", e.data);
    var obj = JSON.parse(e.data);
    document.getElementById("MY_TEMPERATURE").innerHTML = obj.MY_TEMPERATURE;
    document.getElementById("MY_HUMIDITY").innerHTML = obj.MY_HUMIDITY;
  }, false);
  source.addEventListener('solar_readings', function(e) {
    console.log("solar_readings", e.data);
    var obj = JSON.parse(e.data);
    document.getElementById("UVindex").innerHTML = obj.UVindex;
    document.getElementById("SOLAR_INTENSITY").innerHTML = obj.SOLAR_INTENSITY;
  }, false);


  source.addEventListener('status_readings', function(e) {
    console.log("status_readings", e.data);
    var obj = JSON.parse(e.data);

    document.getElementById("AUTOVALVE_PANEL_STATUS").innerHTML = obj.AUTOVALVE_PANEL_STATUS;
    document.getElementById("SPRAYER_STATUS").innerHTML = obj.SPRAYER_STATUS;
    document.getElementById("SETIME_12").innerHTML = obj.SETIME_12;
      document.getElementById("SETIME_SP").innerHTML = obj.SETIME_SP;
    document.getElementById("BOX1_STATUS").innerHTML = obj.BOX1_STATUS;
    document.getElementById("BOX2_STATUS").innerHTML = obj.BOX2_STATUS;
    document.getElementById("BOX3_STATUS").innerHTML = obj.BOX3_STATUS;
    document.getElementById("BOX4_STATUS").innerHTML = obj.BOX4_STATUS;
    document.getElementById("BOX1_THRESOLD_ACTIVE").innerHTML = obj.BOX1_THRESOLD_ACTIVE;
    document.getElementById("BOX2_THRESOLD_ACTIVE").innerHTML = obj.BOX2_THRESOLD_ACTIVE;
    document.getElementById("BOX3_THRESOLD_ACTIVE").innerHTML = obj.BOX3_THRESOLD_ACTIVE;
    document.getElementById("BOX4_THRESOLD_ACTIVE").innerHTML = obj.BOX4_THRESOLD_ACTIVE;

  }, false);
  //==================================================BOX STATUS==================================


  //===============================================================================================

  function myFunction1(element) {

    var x1 = document.getElementById("myDIV_1");
    if (x1.innerHTML === " ") {
    } else {
        x1.innerHTML = " ";
    }
    var xhr1 = new XMLHttpRequest();
    xhr1.open("GET", "/myDIV_1" ,true);
    xhr1.send();
  }

    function myFunction2(element) {
      var x2 = document.getElementById("myDIV_2");
      if (x2.innerHTML === "") {
          } else {
        x2.innerHTML = "";
      }
      var xhr2 = new XMLHttpRequest();
      xhr2.open("GET", "/myDIV_2" ,true);
       xhr2.send();
    }


      function myFunction6(element) {
        var x6 = document.getElementById("myDIV_6");
        if (x6.innerHTML === "") {

        } else {
          x6.innerHTML = "";
        }
        var xhr6 = new XMLHttpRequest();
        xhr6.open("GET", "/myDIV_6" ,true);
        xhr6.send();

      }

      function myFunction7(element) {
        var x7 = document.getElementById("myDIV_7");
        if (x7.innerHTML === "") {

        } else {
          x7.innerHTML = "";
        }
        var xhr7 = new XMLHttpRequest();
        xhr7.open("GET", "/myDIV_7" ,true);
        xhr7.send();

      }

      function myFunction3(element) {

        var x3 = document.getElementById("myDIV_3");
        if (x3.innerHTML === "") {

        } else {
          x3.innerHTML = "";
        }
        var xhr3 = new XMLHttpRequest();
        xhr3.open("GET", "/myDIV_3" ,true);
        xhr3.send();

      }

      function myFunction4(element) {
        var x4 = document.getElementById("myDIV_4");
        if (x4.innerHTML === "") {

        } else {
          x4.innerHTML = "";
        }
        var xhr4 = new XMLHttpRequest();
        xhr4.open("GET", "/myDIV_4" ,true);
        xhr4.send();

      }
      function myFunction5(element) {
        var x5 = document.getElementById("myDIV_5");
        if (x5.innerHTML === "") {

        } else {
          x5.innerHTML = "";
        }
        var xhr5 = new XMLHttpRequest();
        xhr5.open("GET", "/myDIV_5" ,true);
        xhr5.send();

      }
//==================================================BOX1 ADD================================================================================
function myFunction30(element) {
  var x30 = document.getElementById("myDIV_30");
  if (x30.innerHTML === "") {

  } else {
    x30.innerHTML = "";
  }
  var xhr30 = new XMLHttpRequest();
  xhr30.open("GET", "/myDIV_30" ,true);
  xhr30.send();

}
//========================================================================================================================================
//==================================================BOX1 REMOVE================================================================================
function myFunction31(element) {
  var x31 = document.getElementById("myDIV_31");
  if (x31.innerHTML === "") {

  } else {
    x31.innerHTML = "";
  }
  var xhr31 = new XMLHttpRequest();
  xhr31.open("GET", "/myDIV_31" ,true);
  xhr31.send();

}
//========================================================================================================================================
//==================================================BOX2 ADD================================================================================
function myFunction32(element) {
  var x32 = document.getElementById("myDIV_32");
  if (x32.innerHTML === "") {

  } else {
    x32.innerHTML = "";
  }
  var xhr32 = new XMLHttpRequest();
  xhr32.open("GET", "/myDIV_32" ,true);
  xhr32.send();

}
//========================================================================================================================================
//==================================================BOX2 REMOVE================================================================================
function myFunction33(element) {
  var x33 = document.getElementById("myDIV_33");
  if (x33.innerHTML === "") {

  } else {
    x33.innerHTML = "";
  }
  var xhr33 = new XMLHttpRequest();
  xhr33.open("GET", "/myDIV_33" ,true);
  xhr33.send();

}
//========================================================================================================================================
//==================================================BOX3 ADD================================================================================
function myFunction34(element) {
  var x34 = document.getElementById("myDIV_34");
  if (x34.innerHTML === "") {

  } else {
    x34.innerHTML = "";
  }
  var xhr34 = new XMLHttpRequest();
  xhr34.open("GET", "/myDIV_34" ,true);
  xhr34.send();

}
//========================================================================================================================================
//==================================================BOX3 REMOVE================================================================================
function myFunction35(element) {
  var x35 = document.getElementById("myDIV_35");
  if (x35.innerHTML === "") {

  } else {
    x35.innerHTML = "";
  }
  var xhr35 = new XMLHttpRequest();
  xhr35.open("GET", "/myDIV_35" ,true);
  xhr35.send();

}
//========================================================================================================================================
//==================================================BOX4 ADD================================================================================
function myFunction36(element) {
  var x36 = document.getElementById("myDIV_36");
  if (x36.innerHTML === "") {

  } else {
    x36.innerHTML = "";
  }
  var xhr36 = new XMLHttpRequest();
  xhr36.open("GET", "/myDIV_36" ,true);
  xhr36.send();

}
//========================================================================================================================================
//==================================================BOX4 REMOVE================================================================================
function myFunction37(element) {
  var x37 = document.getElementById("myDIV_37");
  if (x37.innerHTML === "") {

  } else {
    x37.innerHTML = "";
  }
  var xhr37 = new XMLHttpRequest();
  xhr37.open("GET", "/myDIV_37" ,true);
  xhr37.send();

}
//=============================================THRESOLD BOX1=========================================================================
function myFunction3(element) {
  var x3 = document.getElementById("myDIV_3");
  if (x3.innerHTML === "") {
      } else {
    x3.innerHTML = "";
  }
  var xhr3 = new XMLHttpRequest();
  xhr3.open("GET", "/myDIV_3" ,true);
   xhr3.send();
}
function myFunction4(element) {
  var x4 = document.getElementById("myDIV_4");
  if (x4.innerHTML === "") {
      } else {
    x4.innerHTML = "";
  }
  var xhr4 = new XMLHttpRequest();
  xhr4.open("GET", "/myDIV_4" ,true);
   xhr4.send();
}

function myFunction5(element) {
  var x5 = document.getElementById("myDIV_5");
  if (x5.innerHTML === "") {
      } else {
    x5.innerHTML = "";
  }
  var xhr5 = new XMLHttpRequest();
  xhr5.open("GET", "/myDIV_5" ,true);
   xhr5.send();
}
//=============================================THRESOLD BOX2=========================================================================
function myFunction13(element) {
  var x13 = document.getElementById("myDIV_13");
  if (x13.innerHTML === "") {
      } else {
    x13.innerHTML = "";
  }
  var xhr13 = new XMLHttpRequest();
  xhr13.open("GET", "/myDIV_13" ,true);
   xhr13.send();
}
function myFunction14(element) {
  var x14 = document.getElementById("myDIV_14");
  if (x14.innerHTML === "") {
      } else {
    x14.innerHTML = "";
  }
  var xhr14 = new XMLHttpRequest();
  xhr14.open("GET", "/myDIV_14" ,true);
   xhr14.send();
}

function myFunction15(element) {
  var x15 = document.getElementById("myDIV_15");
  if (x15.innerHTML === "") {
      } else {
    x15.innerHTML = "";
  }
  var xhr15 = new XMLHttpRequest();
  xhr15.open("GET", "/myDIV_15" ,true);
   xhr15.send();
}
//=============================================THRESOLD BOX3=========================================================================
function myFunction23(element) {
  var x23 = document.getElementById("myDIV_23");
  if (x23.innerHTML === "") {
      } else {
    x23.innerHTML = "";
  }
  var xhr23 = new XMLHttpRequest();
  xhr23.open("GET", "/myDIV_23" ,true);
   xhr23.send();
}
function myFunction24(element) {
  var x24 = document.getElementById("myDIV_24");
  if (x4.innerHTML === "") {
      } else {
    x24.innerHTML = "";
  }
  var xhr24 = new XMLHttpRequest();
  xhr24.open("GET", "/myDIV_24" ,true);
   xhr24.send();
}

function myFunction25(element) {
  var x25 = document.getElementById("myDIV_25");
  if (x25.innerHTML === "") {
      } else {
    x25.innerHTML = "";
  }
  var xhr25 = new XMLHttpRequest();
  xhr25.open("GET", "/myDIV_25" ,true);
   xhr25.send();
}
//=============================================THRESOLD BOX4=========================================================================
function myFunction43(element) {
  var x43 = document.getElementById("myDIV_43");
  if (x43.innerHTML === "") {
      } else {
    x43.innerHTML = "";
  }
  var xhr43 = new XMLHttpRequest();
  xhr43.open("GET", "/myDIV_43" ,true);
   xhr43.send();
}
function myFunction44(element) {
  var x44 = document.getElementById("myDIV_44");
  if (x44.innerHTML === "") {
      } else {
    x44.innerHTML = "";
  }
  var xhr44 = new XMLHttpRequest();
  xhr44.open("GET", "/myDIV_44" ,true);
   xhr44.send();
}

function myFunction45(element) {
  var x45 = document.getElementById("myDIV_45");
  if (x45.innerHTML === "") {
      } else {
    x45.innerHTML = "";
  }
  var xhr45 = new XMLHttpRequest();
  xhr45.open("GET", "/myDIV_45" ,true);
   xhr45.send();
}



//==================================================================================================================================
}
