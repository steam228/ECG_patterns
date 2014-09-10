

// Graphing sketch


// This program takes ASCII-encoded strings

import processing.serial.*;

Serial myPort; 

int xpos = 0;
int ypos = 30;
int interval = 1000;

int time = 0;
void setup () {
  // set the window size:
  size(800, 300);        

  println(Serial.list());
  myPort = new Serial(this, "/dev/tty.usbserial-A9005bkU", 115200); //porta introduzida à unha
  myPort.bufferUntil('\n');
  background(0);
}
void draw () {


  if (millis()-time <= interval) {
    background(0);
    text(time, xpos, ypos);
    xpos = xpos+30;
    
    if (xpos > width) {
      xpos = 0;
      ypos = ypos+10;
    }
  }
  if (millis()-time >= interval) {
    ypos = 30;
    
  }

time = millis();
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to an int and map to the screen height:
    float inByte = float(inString);
  }
}

