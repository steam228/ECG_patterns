int diametro, margem;

void setup() {
  size(640,480);
  diametro = 25;
  margem = 6;
  smooth();
  //frameRate(30);
}
 
void draw() {
  background(255);
  for (int i = (diametro/2 + margem); i <= (height - diametro/2 - margem); i = (i + diametro + margem))
    drawCircle(width-diametro/2-margem,i,diametro);

}
 
void drawCircle(float x, float y, float diam) {
  stroke(0);
  noFill();
  ellipse(x, y, diam, diam);
  if(x - diam - margem > diam/2 + margem){
    drawCircle(x - diam - margem, y, diam);  
  }
 
}
