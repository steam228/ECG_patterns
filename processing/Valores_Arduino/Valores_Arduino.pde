//GRAPH ECG MODIFICADO

import processing.serial.*;

Serial myPort;        // The serial port
float inByte, inByteMax, inByteMin;
int timeall;
float pos;
void setup () {
  colorMode(RGB);
  frameRate(18);
  size(800, 300);        
  // List all the available serial ports
  println(Serial.list());

  float inByteMax = 0;
  float inByteMin = 1023;

  myPort = new Serial(this, "/dev/tty.usbserial-A9005bkU", 115200); // Serial.list()[0], 115200);
  myPort.bufferUntil('\n');

  background(0);
  timeall = millis();
}

void draw () {


  // tudo do draw, pode ficar no serialEvent()
}

void serialEvent (Serial myPort) {
  //// NÃO TENS QUE PERCEBER:



  // while (millis () <= 5000+timeall) {
  //   String inString = myPort.readStringUntil('\n');

  //   if (inString != null) {
  //     inString = trim(inString);
  //     float inByte = float(inString);

  //     if (inByte <inByteMin) {
  //       inByteMin = inByte;
  //     }
  //     if (inByte > inByteMax) {
  //       inByteMax = inByte;
  //     }
  //   }
  // }
 

  String inString = myPort.readStringUntil('\n');

  if (inString != null) {

    inString = trim(inString);
    float inByte = float(inString);
    pos = map(inByte, 0,1023, inByteMin-10, inByteMax+10);
      background(pos);
      pushMatrix();
      translate(width*0.2, height*0.5);
      rect(0,0,-pos*20,20);
      popMatrix();
      // pushMatrix();
      // translate(width*0.2, height*0.5);
      // rotate(frameCount*2 / pos);
      // polygon(0, 0, pos*7, 5);
      // rotate(frameCount*5-pos);
      // scale(pos/10);
      // polygon(0, 0, pos*7, 3);
      // popMatrix();
      // pushMatrix();
      // translate(width*0.4, height*0.5);
      // rotate(frameCount*2 / pos);
      // polygon(0, 0, pos*7, 4);
      // rotate(frameCount*5-pos);
      // scale(pos/10);
      // polygon(0, 0, pos*7, 7);
      // popMatrix();
      // pushMatrix();
      // translate(width*0.6, height*0.5);
      // rotate(frameCount*2 / pos);
      // polygon(0, 0, pos*7, 5);
      // rotate(frameCount*5-pos);
      // scale(pos/10);
      // polygon(0, 0, pos*7, 4);
      // popMatrix();
      // pushMatrix();
      // translate(width*0.8, height*0.5);
      // rotate(frameCount*2 / pos);
      // scale(pos/10);
      // polygon(0, 0, pos*7, 3);
      // rotate(frameCount*5-pos);
      // polygon(0, 0, pos*7, 6);
      // popMatrix();
    ////  text(inByteMax, 60, 60);
    ////  text(inByteMin, 60, 180);
    text(inByte, 60, 250);
     
  }
}

void polygon(float x, float y, float radius, int npoints) {
  noFill();
  stroke(255);
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
