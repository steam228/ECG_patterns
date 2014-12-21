int radius;
int vertices;
int rotation;



void setup() {
  frameRate(15);
  size(800, 600);
}

void draw() {
  background(0);
  stroke(255);
  noFill();
  strokeWeight(2);
  rotation = int(random(5));
  rotation = int(map(rotation,0,5,-50,50));


  pushMatrix();
  translate(width*0.2, height*0.5);
  rotate(frameCount / 200.0);
  polygon(0, 0);
  popMatrix();

  pushMatrix();
  translate(width*0.4, height*0.5);
  rotate(frameCount / 50.0);
  polygon(0, 0);
  popMatrix();


  pushMatrix();
  translate(width*0.6, height*0.5);
  rotate(frameCount / -100.0);
  polygon(0, 0);
  popMatrix();


  pushMatrix();
  translate(width*0.8, height*0.5);
  rotate(frameCount / -100.0);
  polygon(0, 0);
  popMatrix();
}

void polygon(float x, float y) {
  radius = int(random(10));
  radius = int(map(radius,0,10,70,90));
  vertices = int(random(7));
  vertices = int(map(vertices,0,7,3,8));
  float angle = TWO_PI / vertices;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
