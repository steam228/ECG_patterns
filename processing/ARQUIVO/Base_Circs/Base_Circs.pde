
int numCirc = 20;
int margem = 1; //pixeis de margem

float time;
int wait = 1000;

//variáveis a obter 3 dimensões

int beatrate = 0;
float levelX = 0;
float levelY= 0;




void setup() {
  size(640, 480);
  background(255);
  stroke (255);
  strokeWeight (1);
  background(255);
  smooth();
  frameRate(1); //alternativa a contagem do tempo, Aqui defino 1 frame por segundo. Mas a diminuição das bolas está a deixar rasto

  time = millis();
}

void draw () {

  int numCircH = (height*numCirc)/width;
  int centrosW = width/numCirc;
  int centrosH = height/numCircH;

  //if (millis() - time <= wait) {
    //stroke (100);
    
    for (int i = centrosW; i < width; i = i+centrosW) {
      for (int l = centrosH; l < height; l = l+centrosH) {
        //usar valores de leveX e levelY para alterar as cores do círculo. aqui está como random, mas pode ser como input de uma medida. Tipo, mais vermelho se a pessoa estiver mais excitada
        // e mais azul se a pessoa estiver mais calma
        levelX = random(0,1);
        levelY = random(0,1);
        float m = map(levelX, 0, 1, 0, 255);
        float n = map(levelX, 0, 1, 0, 255);
        fill(m, 120, n);
        ellipse (i, l, (centrosW-margem), (centrosW-margem));
      }
    }
  //}

  //else {
   //background(255);
   //time = millis();
   margem++;
   if (margem > centrosW){
     margem = 1;
     background(255);
   }
  //}
}
