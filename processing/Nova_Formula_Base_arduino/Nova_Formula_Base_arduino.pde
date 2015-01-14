import processing.pdf.*;
import processing.serial.*;

Serial myPort;

int radius;
int vertices1, vertices2, vertices3, vertices4, vertices5, vertices6, vertices7, vertices8;
int rotation, rotation2;
int valormax, valormin, indice, ecgvalue;
int threshold;

String newfilename;
int fileNumber;
String Numberfile;
String fileNamebase;

boolean doSth = true;
boolean muda_vertices;

Table table; //tabela para carregar valores a partir de ficheiro csv

void setup() {
  frameRate(8);
  size(1024, 720);
  newfilename = "fulano1";
  fileNamebase = "fulano";
  fileNumber = 0;
  indice = 0;
  ecgvalue = 0;
  rotation =0;
  threshold = 540;
  muda_vertices = true;
  beginRecord(PDF, newfilename); 

 
   // List all the available serial ports
  println(Serial.list());
  // I know that the first port in the serial list on my mac
  // is always my  Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  //myPort = new Serial(this, Serial.list()[0], 115200);
  myPort = new Serial(this, "/dev/tty.usbserial-A9005bkU", 115200); // Serial.list()[0], 115200);
  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');
  // set inital background:
  background(0); 
   
   
   //************************************************************************************************************************
  // Parcela de código que carrega números de um csv para uma tabela de ints, para simular o ECG *****
  // e calcula o valor máximo e mínimo 
  
  
  table = loadTable("Workbook.csv");
  
  valormax = table.getInt(0,0);
  valormin = table.getInt(0,0);
    
  for (int i=1; i < table.getRowCount(); i++){
    if (table.getInt(i,0) > valormax)
      valormax = table.getInt(i,0);
    if (table.getInt(i,0) < valormin)
      valormin = table.getInt(i,0);   
  }    
  
  


}

void draw() {
  


}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to an int and map to the screen height:
    float inByte = float(inString); 
    ecgvalue = (int)inByte;

  if (doSth == true) {
  background(30);
  strokeWeight(1);

  if (ecgvalue > threshold){
    rotation = int(random(10));
    rotation = int(map(rotation, 0, 10, 0, 360));
    muda_vertices = true; //só muda a figura geométrica acima de determinado threshold
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
  }


  pushMatrix();
  translate(width*0.2, height*0.5);
  rotate(rotation);
  polygon(0, 0, vertices1);
  rotate(rotation);
  polygon(0, 0, vertices2);
  popMatrix();

  pushMatrix();
  translate(width*0.4, height*0.5);
  rotate(rotation);
  polygon(0, 0, vertices3);
  rotate(rotation);
  polygon(0, 0, vertices4);
  popMatrix();


  pushMatrix();
  translate(width*0.6, height*0.5);
  rotate(rotation);
  polygon(0, 0, vertices5);
  rotate(rotation);
  polygon(0, 0, vertices6);
  popMatrix();

  pushMatrix();
  translate(width*0.8, height*0.5);
  rotate(rotation);
  polygon(0, 0, vertices7);
  rotate(rotation);
  polygon(0, 0, vertices8);
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



}

void polygon(float x, float y, int vertices) {

  
    radius = (int)map(ecgvalue, valormin, valormax, 10, 120); //tamanho do polígono passa a depender dos valores de ECG para simular o batimento cardíaco
    
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
