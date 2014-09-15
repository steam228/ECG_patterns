import processing.serial.*;

Serial myPort; 

int xpos = 0;
int ypos;
int interval = 4000;

int time = 0;
int previousTime = 0;
float raio;

float inByte;

float[] valsArr;

float MAX = 700, MIN;
int BEAT = 0;
int tresMax = 30;

void setup () {
  // set the window size:
  size(800, 300);        

  println(Serial.list());
  myPort = new Serial(this, "/dev/tty.usbserial-A9005bkU", 115200); //porta introduzida à unha
  myPort.bufferUntil('\n');
  background(0);
  ypos = height/2;
  noStroke();
//  getVals(500);
  getBeat();
}
void draw () {


  if (time-previousTime <= interval) {

    raio = inByte;
    raio = map(raio, 300, 1100, 5, 200);
    bola(xpos, ypos, raio);


    xpos = xpos+30;

    if (xpos > width) {
      background(0);
      text (BEAT, 70, 30, 90);
      text (MAX, 30, 30, 50);
      text (MIN, 30, 70, 50);
      xpos = 0;
    }
  }
  if (time-previousTime >= interval) {
    previousTime = time;
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
    inByte = float(inString);
  }
}

void bola(int xposi, int yposi, float raioi) {

  ellipse(xposi, yposi, raioi, raioi);
}



void getVals (int arraySize) {


  for (int i=0; i<arraySize; i++) {
    valsArr[i] = inByte;
  }

  for (int l=0; l<arraySize; l++) {
    if (l !=0 ) {
      if (valsArr[l] > valsArr[l-1]) {
        MAX = valsArr[l];
      }
      if (valsArr[l] < valsArr[l-1]) {
        MIN = valsArr[l];
      }
    }
  }
}

void getBeat() {

  if (time-previousTime <= interval) {
    if (inByte > MAX-tresMax) {

      BEAT++;
    }
  }

  if (time-previousTime >= interval) {
    previousTime = time;
  }
  time = millis();
}



