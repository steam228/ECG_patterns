import processing.pdf.*;

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
  threshold = 460;
  muda_vertices = true;
  beginRecord(PDF, newfilename); 

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
  
  if (doSth == true) {
  background(30);
  strokeWeight(1);

  
  if (indice < table.getRowCount()){
    ecgvalue = table.getInt(indice,0);
    indice++;
  }
  else
    indice = 0;
    
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
<<<<<<< Updated upstream
  polygon(0, 0, vertices1);
  rotate(rotation);
  polygon(0, 0, vertices2);
=======
  polygon(0, 0);
  rotate(rotation*2);
  polygon(0, 0);
>>>>>>> Stashed changes
  popMatrix();

  pushMatrix();
  translate(width*0.4, height*0.5);
  rotate(rotation);
<<<<<<< Updated upstream
  polygon(0, 0, vertices3);
  rotate(rotation);
  polygon(0, 0, vertices4);
=======
  polygon(0, 0);
  rotate(rotation*2);
  polygon(0, 0);
>>>>>>> Stashed changes
  popMatrix();


  pushMatrix();
  translate(width*0.6, height*0.5);
  rotate(rotation);
<<<<<<< Updated upstream
  polygon(0, 0, vertices5);
  rotate(rotation);
  polygon(0, 0, vertices6);
=======
  polygon(0, 0);
  rotate(rotation*2);
  polygon(0, 0);
>>>>>>> Stashed changes
  popMatrix();

  pushMatrix();
  translate(width*0.8, height*0.5);
  rotate(rotation);
<<<<<<< Updated upstream
  polygon(0, 0, vertices7);
  rotate(rotation);
  polygon(0, 0, vertices8);
=======
  polygon(0, 0);
  rotate(rotation*2);
  polygon(0, 0);
>>>>>>> Stashed changes
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
