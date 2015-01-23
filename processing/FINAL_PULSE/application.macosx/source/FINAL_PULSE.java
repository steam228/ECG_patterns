import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.pdf.*; 
import processing.serial.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class FINAL_PULSE extends PApplet {




Serial port; 

int radius;
int vertices1, vertices2, vertices3, vertices4, vertices5, vertices6, vertices7, vertices8, vertices9, vertices10;
int rotation, rotation2;
int valormax, valormin, indice;
int threshold;

String newfilename;
int fileNumber;
String Numberfile;
String fileNamebase;

boolean doSth = true;
boolean muda_vertices;

boolean beat;
boolean aguarda, calibra;

Table table; //tabela para carregar valores a partir de ficheiro csv

int Sensor, BPM;

int bateu = 0;

public void setup() {
  frameRate(8);
  size(displayWidth, displayHeight);
  newfilename = "fulano1";
  fileNamebase = "fulano";
  fileNumber = 0;
  indice = 0;
  Sensor = 0;
  rotation =0;
  threshold = 540;
  muda_vertices = true;
  beginRecord(PDF, newfilename); 

  // GO FIND THE ARDUINO
  println(Serial.list());    // print a list of available serial ports
  // choose the number between the [] that is connected to the Arduino
  port = new Serial(this, Serial.list()[7], 115200);  // make sure Arduino is talking serial at this baud rate
  port.clear();            // flush buffer
  port.bufferUntil('\n');  // set buffer full flag on receipt of carriage return
  aguarda = true;
  calibra = false;
  background(30);
  textSize(20);  
  textAlign(CENTER, CENTER);
    text ("Coloque o dedo indicador e o outro nas posi\u00e7\u00f5es",(width/2), (height/2));
}    



public void draw() {

  if (!aguarda && !calibra) {
    if (bateu >=30) {
      bateu = 0;
      doSth = false;
    }

    if (doSth == true) {


      background(30);
      fill(255);
      textAlign(LEFT, TOP);
      text(BPM, 20, 20); 
      strokeWeight(1);

      if (beat == true) {
        rotation = PApplet.parseInt(random(10));
        rotation = PApplet.parseInt(map(rotation, 0, 10, 0, 360));
        muda_vertices = true; //s\u00f3 muda a figura geom\u00e9trica acima de determinado threshold
        beat = false;
        bateu++;
        background(255);
      } else
        muda_vertices = false; //abaixoo do tal threshold, mant\u00e9m a figura geom\u00e9trica anterior

      if (muda_vertices) { //uma n\u00famero de v\u00e9rtices por pol\u00edgono. Individualizando assim os v\u00e9rtices para cada pol\u00edgono, permite manter a figura geom\u00e9trica de cada pol\u00edgono, quando abaixo do threshhold definido
        vertices1 = PApplet.parseInt(random(7));
        vertices1 = PApplet.parseInt(map(vertices1, 0, 7, 3, 8));
        vertices2 = PApplet.parseInt(random(7));
        vertices2 = PApplet.parseInt(map(vertices2, 0, 7, 3, 8));
        vertices3 = PApplet.parseInt(random(7));
        vertices3 = PApplet.parseInt(map(vertices3, 0, 7, 3, 8));      
        vertices4 = PApplet.parseInt(random(7));
        vertices4 = PApplet.parseInt(map(vertices4, 0, 7, 3, 8));
        vertices5 = PApplet.parseInt(random(7));
        vertices5 = PApplet.parseInt(map(vertices5, 0, 7, 3, 8));
        vertices6 = PApplet.parseInt(random(7));
        vertices6 = PApplet.parseInt(map(vertices6, 0, 7, 3, 8));
        vertices7 = PApplet.parseInt(random(7));
        vertices7 = PApplet.parseInt(map(vertices7, 0, 7, 3, 8));
        vertices8 = PApplet.parseInt(random(7));
        vertices8 = PApplet.parseInt(map(vertices8, 0, 7, 3, 8));
        vertices9 = PApplet.parseInt(random(7));
        vertices9 = PApplet.parseInt(map(vertices8, 0, 7, 3, 8)); 
        vertices10 = PApplet.parseInt(random(7));
        vertices10 = PApplet.parseInt(map(vertices8, 0, 7, 3, 8));
      }


      pushMatrix();
      translate(width*0.14f, height*0.5f);
      rotate(rotation);
      polygon(0, 0, vertices1);
      rotate(rotation);
      polygon(0, 0, vertices2);
      popMatrix();

      pushMatrix();
      translate(width*0.29f, height*0.5f);
      rotate(rotation);
      polygon(0, 0, vertices3);
      rotate(rotation);
      polygon(0, 0, vertices4);
      popMatrix();


      pushMatrix();
      translate(width*0.43f, height*0.5f);
      rotate(rotation);
      polygon(0, 0, vertices5);
      rotate(rotation);
      polygon(0, 0, vertices6);
      popMatrix();

      pushMatrix();
      translate(width*0.57f, height*0.5f);
      rotate(rotation);
      polygon(0, 0, vertices7);
      rotate(rotation);
      polygon(0, 0, vertices8);
      popMatrix();

      pushMatrix();
      translate(width*0.71f, height*0.5f);
      rotate(rotation);
      polygon(0, 0, vertices9);
      rotate(rotation);
      polygon(0, 0, vertices10);
      popMatrix();

      pushMatrix();
      translate(width*0.86f, height*0.5f);
      rotate(rotation);
      polygon(0, 0, vertices3);
      rotate(rotation);
      polygon(0, 0, vertices6);
      popMatrix();
    } else {
      endRecord();
      fileNumber++;
      Numberfile = str(fileNumber);
      newfilename = fileNamebase + Numberfile + ".pdf";
      beginRecord(PDF, newfilename);
      // background(30);
      // textSize(40);  
      // textAlign(CENTER, CENTER);
      // text ("OBRIGADO", (width/2), (height/2));
      // delay(5000); //tempo de espera entre experiencias
      // aguarda = true;
      doSth = true;
      
    }
  } else if (aguarda ==true) {
    calibra =false; 
    background(30);
    textSize(20);  
    textAlign(CENTER, CENTER);
    text ("Coloque o dedo indicador e o outro nas posi\u00e7\u00f5es", (width/2), (height/2));
  } else if (aguarda ==false && calibra == true) {
    aguarda =false; 
    background(30);
    textSize(40); 
    textAlign(CENTER, CENTER);
    text ("A Calibrar... Aguarde ", (width/2), (height/2));
  }
}

public void serialEvent (Serial myPort) {
  String inData = port.readStringUntil('\n');
  inData = trim(inData);                 // cut off white space (carriage return)

  if (inData.charAt(0) == 'S') {          // leading 'S' for sensor data
    inData = inData.substring(1);
    Sensor = PApplet.parseInt(inData);

    if (Sensor == 3544) { //codigo 4 dig sup a 1023
      aguarda = true;
      calibra = false;
    } else if (Sensor == 2483) { //codigo 4 dig sup a 1023
      calibra = true;
      aguarda = false;
    } else if (Sensor!=3544 || Sensor !=2483) {
      calibra = false;
      aguarda = false;

      println(Sensor);
      // convert the string to usable int
    }
  }
  if (inData.charAt(0) == 'B') {          // leading 'B' for BPM data
    inData = inData.substring(1);        // cut off the leading 'B'
    BPM = PApplet.parseInt(inData);                   // convert the string to usable int
    beat = true;                         // set beat flag to advance heart rate graph
  }
  if (inData.charAt(0) == 'A') {         
    inData = inData.substring(1);       
    valormax = PApplet.parseInt(inData);
    print (" MAX=  ");
    println(valormax);
  } 
  if (inData.charAt(0) == 'I') {         
    inData = inData.substring(1);       
    valormin = PApplet.parseInt(inData);
    print (" MIN=  ");
    println(valormin);
  }
}


public void polygon(float x, float y, int vertices) {


  radius = (int)map(Sensor, valormin, valormax, 10, (width-width/6)/6); //tamanho do pol\u00edgono passa a depender dos valores de ECG para simular o batimento card\u00edaco

  int fille = PApplet.parseInt(random(25));
  fille = PApplet.parseInt(map(fille, 0, 25, 235, 255));
  int opa = PApplet.parseInt(random(25));
  opa = PApplet.parseInt(map(opa, 0, 25, 200, 220));
  stroke(255, 30, 200);
  noFill();


  float angle = TWO_PI / vertices;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a)*radius;
    float sy = y + sin(a)*radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

//fazer PDF
public void keyPressed() {
  if (key == 'q') {
    doSth = false;
  }
}

public void delay(int delay)
{
  int time = millis();
  while(millis() - time <= delay);
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "FINAL_PULSE" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
