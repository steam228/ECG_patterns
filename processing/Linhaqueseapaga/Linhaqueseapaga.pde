int x = 0;
float py = 0;
 
void setup(){
  size(600,200);
  background(0);
}
 
void draw(){
  noStroke();
  fill(0,0,0,15);
  rect(0,0,width,height);
  translate(0,height/2);
  x++;
  x%=width;
  float fx = py + random(-20,20);
  stroke(100,255,100);
  noFill();
  line(x-1,py, x,fx);
  py = fx;
  if(py>height/2) py=height/2;
  if(py<-height/2) py=-height/2;
}
