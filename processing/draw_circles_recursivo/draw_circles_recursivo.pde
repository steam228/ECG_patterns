int raio;

void setup() {
  size(640,480);
  raio = 20;
  frameRate(1);
}
 
void draw() {
  background(255);
  for (int i=10; i <= height-10; i = i + raio)
    drawCircle(width-10,i,raio);
}
 
void drawCircle(float x, float y, float radius) {
  stroke(0);
  noFill();
  ellipse(x, y, radius, radius);
  if(x > radius){
    drawCircle(x - radius, y, radius);  
  }
 
}
