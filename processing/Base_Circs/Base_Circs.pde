
int numCirc = 20;
int margem = 1; //pixeis de margem

float time;
int wait = 1000;

//variáveis a obter 3 dimensões

int beatrate = 0;
int levelX = 0;
int levelY= 0;




void setup() {
  size(640, 480);
  stroke (100);
  strokeWeight (1);
  background(255);
  smooth();

  time = millis();
}

void draw () {

  int numCircH = (height*numCirc)/width;
  int centrosW = width/numCirc;
  int centrosH = height/numCircH;

  if (millis() - time <= wait) {
    stroke (100);
    
    for (int i = centrosW; i < width; i = i+centrosW) {
      for (int l = centrosH; l < height; l = l+centrosH) {
        ellipse (i, l, (centrosW-margem), (centrosW-margem));
      }
    }
  }

  else {
   background(255);
   time = millis();
   margem++;
   if (margem > centrosW){
     margem = 1;
   }
  }
}
