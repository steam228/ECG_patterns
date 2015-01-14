import processing.pdf.*;
import processing.serial.*;

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

Table table; //tabela para carregar valores a partir de ficheiro csv

int Sensor, BPM;

int bateu = 0;

void setup() {
  frameRate(8);
  size(1024, 720);
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

  }    
  


void draw() {
    
  
  if (bateu >=30){
    bateu = 0;
    doSth = false;
  }
  
  if (doSth == true) {
    
 
  background(30);
  fill(255);
    text(BPM,20,20); 
  strokeWeight(1);

  if (beat == true){
    rotation = int(random(10));
    rotation = int(map(rotation, 0, 10, 0, 360));
    muda_vertices = true; //só muda a figura geométrica acima de determinado threshold
    beat = false;
    bateu++;
  }
  else
    muda_vertices = false; //abaixoo do tal threshold, mantém a figura geométrica anterior
    
  if (muda_vertices){ //uma número de vértices por polígono. Individualizando assim os vértices para cada polígono, permite manter a figura geométrica de cada polígono, quando abaixo do threshhold definido
    vertices1 = int(random(7));
    vertices1 = int(map(vertices1, 0, 7, 3, 8));
    vertices2 = int(random(7));
    vertices2 = int(map(vertices2, 0, 7, 3, 8));
    vertices3 = int(random(7));
    vertices3 = int(map(vertices3, 0, 7, 3, 8));      
    vertices4 = int(random(7));
    vertices4 = int(map(vertices4, 0, 7, 3, 8));
    vertices5 = int(random(7));
    vertices5 = int(map(vertices5, 0, 7, 3, 8));
    vertices6 = int(random(7));
    vertices6 = int(map(vertices6, 0, 7, 3, 8));
    vertices7 = int(random(7));
    vertices7 = int(map(vertices7, 0, 7, 3, 8));
    vertices8 = int(random(7));
    vertices8 = int(map(vertices8, 0, 7, 3, 8));
    vertices9 = int(random(7));
    vertices9 = int(map(vertices8, 0, 7, 3, 8)); 
    vertices10 = int(random(7));
    vertices10 = int(map(vertices8, 0, 7, 3, 8)); 
  }


  pushMatrix();
  translate(width*0.14, height*0.5);
  rotate(rotation);
  polygon(0, 0, vertices1);
  rotate(rotation);
  polygon(0, 0, vertices2);
  popMatrix();

  pushMatrix();
  translate(width*0.29, height*0.5);
  rotate(rotation);
  polygon(0, 0, vertices3);
  rotate(rotation);
  polygon(0, 0, vertices4);
  popMatrix();


  pushMatrix();
  translate(width*0.43, height*0.5);
  rotate(rotation);
  polygon(0, 0, vertices5);
  rotate(rotation);
  polygon(0, 0, vertices6);
  popMatrix();

  pushMatrix();
  translate(width*0.57, height*0.5);
  rotate(rotation);
  polygon(0, 0, vertices7);
  rotate(rotation);
  polygon(0, 0, vertices8);
  popMatrix();
  
  pushMatrix();
  translate(width*0.71, height*0.5);
  rotate(rotation);
  polygon(0, 0, vertices9);
  rotate(rotation);
  polygon(0, 0, vertices10);
  popMatrix();
  
  pushMatrix();
  translate(width*0.86, height*0.5);
  rotate(rotation);
  polygon(0, 0, vertices3);
  rotate(rotation);
  polygon(0, 0, vertices6);
  popMatrix();
}

else {
endRecord();
fileNumber++;
Numberfile = str(fileNumber);
newfilename = fileNamebase + Numberfile + ".pdf";
beginRecord(PDF, newfilename);
doSth = true;

}

}


void serialEvent (Serial myPort) {
   String inData = port.readStringUntil('\n');
   inData = trim(inData);                 // cut off white space (carriage return)
   
   if (inData.charAt(0) == 'S'){          // leading 'S' for sensor data
     inData = inData.substring(1);        // cut off the leading 'S'
     Sensor = int(inData);
     println(Sensor);
     // convert the string to usable int
   }
   if (inData.charAt(0) == 'B'){          // leading 'B' for BPM data
     inData = inData.substring(1);        // cut off the leading 'B'
     BPM = int(inData);                   // convert the string to usable int
     beat = true;                         // set beat flag to advance heart rate graph

   }
     if (inData.charAt(0) == 'A'){         
     inData = inData.substring(1);       
     valormax = int(inData);
     print (" MAX=  ");
     println(valormax);
   } 
     if (inData.charAt(0) == 'I'){         
     inData = inData.substring(1);       
     valormin = int(inData);
     print (" MIN=  ");
     println(valormin);
   }

}

 
void polygon(float x, float y, int vertices) {

  
    radius = (int)map(Sensor, valormin, valormax, 10, 120); //tamanho do polígono passa a depender dos valores de ECG para simular o batimento cardíaco
    
    int fille = int(random(25));
    fille = int(map(fille, 0, 25, 235, 255));
    int opa = int(random(25));
    opa = int(map(opa, 0, 25, 200, 220));
    stroke(fille);
    fill(fille, opa);
    

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
void keyPressed() {
  if (key == 'q') {
doSth = false;
  }
}
