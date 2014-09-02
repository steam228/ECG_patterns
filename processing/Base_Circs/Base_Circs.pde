
int numCirc = 20;
int margem = 10; //pixeis de margem


void setup() {
  size(640, 480);
  stroke (255);

  


}

void draw () {
  int numCircH = (height*numCirc)/width;
  int centrosW = width/numCirc;
  int centrosH = height/numCircH;
  
  for (int i = centrosW; i < width; i = i+centrosW) {
    for (int l = centrosH; l < height; l = l+centrosH) {
      ellipse (i,l,(centrosW-margem),(centrosW-margem));
    }
  }
}
