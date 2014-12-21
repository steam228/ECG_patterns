import processing.pdf.*;

int radius;
int vertices;
int rotation;


int traco = 4; // nao conta exteriencias

void setup() {
  frameRate(8);
  size(800, 600);
  beginRecord(PDF, "fulano1.pdf"); 


}

void draw() {
  background(0);
  noStroke();
  noFill();
  strokeWeight(2);
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

void polygon(float x, float y) {


  radius = int(random(10));
  radius = int(map(radius, 0, 10, 50, 90));
  vertices = int(random(7));
  vertices = int(map(vertices, 0, 7, 3, 8));

    int fille = int(random(25));
    fille = int(map(fille, 0, 25, 220, 255));
    int opa = int(random(25));
    opa = int(map(opa, 0, 25, 150, 255));
    fill(fille, opa);

    traco = 4;
    

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
    endRecord();
    exit();
  }
}
