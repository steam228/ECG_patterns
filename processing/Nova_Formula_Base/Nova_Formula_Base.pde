import processing.pdf.*;

int radius;
int vertices;
int rotation;

String newfilename;
int fileNumber;
String Numberfile;
String fileNamebase;

boolean doSth = true;

void setup() {
  frameRate(8);
  size(1024, 720);
  newfilename = "fulano1";
  fileNamebase = "fulano";
  fileNumber = 0;
  beginRecord(PDF, newfilename); 


}

void draw() {
  
  if (doSth == true) {
  background(30);
  strokeWeight(1);
  rotation = int(random(5));
  rotation = int(map(rotation, 0, 5, 0, 360));


  pushMatrix();
  translate(width*0.2, height*0.5);
  rotate(rotation);
  polygon(0, 0);
  rotate(rotation);
  polygon(0, 0);
  popMatrix();

  pushMatrix();
  translate(width*0.4, height*0.5);
  rotate(rotation);
  polygon(0, 0);
  rotate(rotation);
  polygon(0, 0);
  popMatrix();


  pushMatrix();
  translate(width*0.6, height*0.5);
  rotate(rotation);
  polygon(0, 0);
  rotate(rotation);
  polygon(0, 0);
  popMatrix();


  pushMatrix();
  translate(width*0.8, height*0.5);
  rotate(rotation);
  polygon(0, 0);
  rotate(rotation);
  polygon(0, 0);
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


void polygon(float x, float y) {


  radius = int(random(10));
  radius = int(map(radius, 0, 10, 50, 90));
  vertices = int(random(7));
  vertices = int(map(vertices, 0, 7, 3, 8));

    int fille = int(random(25));
    fille = int(map(fille, 0, 25, 235, 255));
    int opa = int(random(25));
    opa = int(map(opa, 0, 25, 200, 220));
    stroke(fille);
    fill(fille, opa);
    


    

  float angle = TWO_PI / vertices;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
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
