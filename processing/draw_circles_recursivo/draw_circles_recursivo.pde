int diametro, margem;

void setup() {
  size(640,480);
  diametro = 20;
  margem = 4;
  smooth();
  frameRate(10);
}
 
void draw() {
  background(255);
  translate(width/2, height/2);
  for (int i = 0; i <= (height/2 - diametro/2 - margem); i = (i + diametro + margem))
    drawCircle(0,i,diametro);
  for (int i = 0; i >= (-1*height/2 + diametro/2 + margem); i = (i - diametro - margem))
    drawCircle(0,i,diametro);
  
  fillCircle();

}
 
void drawCircle(float x, float y, float diam) {
  stroke(0);
  noFill();
  ellipse(x, y, diam, diam);
  ellipse(-1*x, y, diam, diam);
  if(x - diam - margem > -1*width/2 + diam/2 + margem){
    drawCircle(x - diam - margem, y, diam);  
  }
}

void fillCircle(){
  fill(100);
  int max = (int)random(1,8);
  for (int i = 0; i < max; i++)
    ellipse(0,-1*i*(diametro+margem),diametro,diametro);
}
