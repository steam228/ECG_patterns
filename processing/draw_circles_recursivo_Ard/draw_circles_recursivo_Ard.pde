import processing.serial.*;
int diametro, margem, heartbeat, lado, moldura, nquadrados, valormax, valormin, indice, ecgvalue;


PShape quadrado, quadrado1, quadrado2, quadrado3, quadrado4, quadrado5;

Serial myPort; 


int maxBat, minBat;

int time;
int inByte;

String inString;

int arrayVals[];
int arrayTam;

int dados[];




void setup() {
  size(640, 480);
  diametro = 20;
  nquadrados = 13; //variável que ficará com o nº quadrados escolhido pelo utilizador
  margem = 0; // margem entre quadrados dentro da janela
  heartbeat = 1;
  moldura = 400; //tamanho da janela onde vai ficar a matriz
  indice = 0;
  ecgvalue = 0;
  lado = moldura/nquadrados;
  smooth();
  frameRate(8); //para ajustar depois conforme a velocidade que se pretenda
  quadrado1 = loadShape("quadrado.svg");
  quadrado2 = loadShape("quadrado2.svg");
  quadrado3 = loadShape("quadrado3.svg");
  quadrado4 = loadShape("quadrado4.svg");
  quadrado5 = loadShape("quadrado5.svg");

  //Serial com
  println(Serial.list()); 
  myPort = new Serial(this, Serial.list()[3], 115200);

  maxBat = 0;
  minBat = 1023;
  inByte = 0;
  arrayTam = 0;


  time = millis();
  
  //************************************************************************************************************************
  // Parcela de código que carrega números num txt para um array de ints, para simular o ECG *****
  // e calcula o valor máximo e mínimo
  
  // Load text file as a string
  String[] stuff = loadStrings("dados.txt");
  // Convert string into an array of integers using ',' as a delimiter
  dados = int(split(stuff[0],','));
  
  valormax = dados[0];
  valormin = dados[0];
  
  for (int i=1; i < dados.length; i++){
    if (dados[i] > valormax)
      valormax = dados[i];
    if (dados[i] < valormin)
      valormin = dados[i];   
  }
  
  println("max :", valormax);
  println("min :", valormin);  
  
 // ************************************************************************************************************************ 
  
}

void draw() {
  background(255);
  translate(width/2, height/2); // coloca a coordenada (0,0) no centro do ecrã
  if (arrayTam == 3000) {
      analisa();
      println ("max:  ", maxBat);
      println ("min:  ", minBat);
    }
  //código se a matriz for feita de círculos
  /*for (int i = 0; i <= (height/2 - diametro/2 - margem); i = (i + diametro + margem))
   drawCircle(0,i,diametro);
   for (int i = 0; i >= (-1*height/2 + diametro/2 + margem); i = (i - diametro - margem))
   drawCircle(0,i,diametro);*/

  //código se a matriz for feita de quadrados  
  for (int i = 0; i <= (height/2 - lado/2 - margem); i = (i + lado + margem))
    drawRect(0-lado/2, i-lado/2, lado);
  for (int i = 0; i >= (-1*height/2 + lado/2 + margem); i = (i - lado - margem))
    drawRect(0-lado/2, i-lado/2, lado);

  fillRect();
}

void drawCircle(float x, float y, float diam) { //função que desenha a matriz de círculos
  stroke(0);
  noFill();
  ellipse(x, y, diam, diam);
  ellipse(-1*x, y, diam, diam);
  if (x - diam - margem > -1*width/2 + diam/2 + margem) {
    drawCircle(x - diam - margem, y, diam);
  }
}

void serialEvent (Serial myPort) {
  // get the ASCII string:



  inString = myPort.readStringUntil('\n');

  if (inString != null) {
    inString = trim(inString);
    inByte = int(inString);
    println(inByte);
    if (arrayTam < 3000) {
      arrayVals[arrayTam] = inByte;
      arrayTam++;
    } 
  }
}


void drawRect(float x, float y, float side) { //função que desenha a matriz de rectângulos
  stroke(0);
  noFill();
  rect(x, y, side, side);
  /*if(-1*x + side + margem < width/2 - margem){
   rect(-1*x + margem, y, side, side);
   }
   if(x - side - margem > -1*width/2 + margem){
   drawRect(x - side - margem, y, side);  
   }*/


  // não percebi ainda porque a matriz fica desproporcionada se número de quadrados for >= 11x11

  if (-1*x + side + margem < moldura/2 - margem) {
    rect(-1*x + margem, y, side, side);
  }
  if (x - side - margem > -1*moldura/2 + margem) {
    drawRect(x - side - margem, y, side);
  }
}

void fillCircle() { //função que pinta os círculos
  fill(0);
  int yaxis = (int)random(1, 8); //valores que alteram a cor nos eixos x e y
  //int contador1 = yaxis;
  //int contador2 = 9 - yaxis; // 9 para este exemplo com random até 8
  int contador1 = yaxis; //(int)random(1,8);
  int contador2 = yaxis; //(int)random(1,8);

  if (yaxis > 4) { // eixo y maior
    for (int k = 0; k <= 9 - yaxis; k++) {
      for (int i = 0; i <= contador1; i++) { //pinta eixo y
        if (heartbeat == 20) {
          fill(255);
          heartbeat = 0;
        } else {
          fill(0);
          heartbeat++;
        }

        ellipse(-1*k*(diametro+margem), -1*i*(diametro+margem), diametro, diametro);
        ellipse(k*(diametro+margem), -1*i*(diametro+margem), diametro, diametro); //simetria
        ellipse(-1*k*(diametro+margem), i*(diametro+margem), diametro, diametro); //simetria
        ellipse(k*(diametro+margem), i*(diametro+margem), diametro, diametro); //simetria
      } 
      contador1 = contador1 - 2; //alterar número para dar outros efeitos
    }
  } else { // eixo x maior
    for (int k = 0; k <= 9 - yaxis; k++) {
      for (int i = 0; i <= contador2; i++) { //pinta eixo y
        ellipse(-1*i*(diametro+margem), -1*k*(diametro+margem), diametro, diametro);
        ellipse(-1*i*(diametro+margem), k*(diametro+margem), diametro, diametro); //simetria
        ellipse(i*(diametro+margem), -1*k*(diametro+margem), diametro, diametro); //simetria
        ellipse(i*(diametro+margem), k*(diametro+margem), diametro, diametro); //simetria
      }
      contador2 = contador2 - 2; //alterar número para dar outros efeitos
    }
  }
}

void fillRect() { //função que pinta os rectãngulos
  fill(0);
  int resto = ceil(nquadrados/2); //apenas para este cenário com números random
  //int yaxis = (int)random(1, (resto+1)); //valores que alteram a cor nos eixos x e y
  
  if (indice < dados.length){
    ecgvalue = dados[indice];
    indice++;
  }
  else
    indice = 0;
  
  int yaxis = (int)map(ecgvalue, valormin, valormax, 1, (resto+1));
  //int contador1 = yaxis;
  //int contador2 = 9 - yaxis; // 9 para este exemplo com random até 8
  int contador1 = resto; //(int)random(1,8);
  int contador2 = resto; //(int)random(1,8);

  if (yaxis > floor(resto/2)) { // eixo y maior
    for (int k = 0; k <= resto - yaxis; k++) {
      for (int i = 0; i <= contador1; i++) { //pinta eixo y
        if (heartbeat == 20) {
          fill(255);
          heartbeat = 0;
        } else {
          fill(0);
          heartbeat++;
        }

        // código para pintar quadrados
        /* rect(-1*k*(lado+margem)-lado/2,-1*i*(lado+margem)-lado/2,lado,lado);
         rect(k*(lado+margem)-lado/2,-1*i*(lado+margem)-lado/2,lado,lado); //simetria
         rect(-1*k*(lado+margem)-lado/2,i*(lado+margem)-lado/2,lado,lado); //simetria
         rect(k*(lado+margem)-lado/2,i*(lado+margem)-lado/2,lado,lado); //simetria */


        // código para carregar svgs
        Aleatorio();
        shape(quadrado, -1*k*(lado+margem)-lado/2, -1*i*(lado+margem)-lado/2, lado, lado);
        if (k != 0) {  
          Aleatorio();
          shape(quadrado, k*(lado+margem)-lado/2, -1*i*(lado+margem)-lado/2, lado, lado); //simetria
        }
        if (i != 0) {  
          Aleatorio();
          shape(quadrado, -1*k*(lado+margem)-lado/2, i*(lado+margem)-lado/2, lado, lado); //simetria
        }
        if ( k != 0 && i != 0) {
          Aleatorio();
          shape(quadrado, k*(lado+margem)-lado/2, i*(lado+margem)-lado/2, lado, lado); //simetria
        }
      } 
      contador1 = contador1 - 2; //alterar número para dar outros efeitos
    }
  } else { // eixo x maior
    for (int k = 0; k <= resto - yaxis; k++) {
      for (int i = 0; i <= contador2; i++) { //pinta eixo y

        // código para pintar quadrados
        //rect(quadrado, -1*i*(lado+margem)-lado/2,-1*k*(lado+margem)-lado/2,lado,lado);
        //rect(quadrado, -1*i*(lado+margem)-lado/2,k*(lado+margem)-lado/2,lado,lado); //simetria
        //rect(quadrado, i*(lado+margem)-lado/2,-1*k*(lado+margem)-lado/2,lado,lado); //simetria
        //rect(quadrado, i*(lado+margem)-lado/2,k*(lado+margem)-lado/2,lado,lado); //simetria



        // código para carregar svgs
        Aleatorio();
        shape(quadrado, -1*i*(lado+margem)-lado/2, -1*k*(lado+margem)-lado/2, lado, lado);
        if (k != 0) { 
          Aleatorio();
          shape(quadrado, -1*i*(lado+margem)-lado/2, k*(lado+margem)-lado/2, lado, lado); //simetria
        }
        if (i != 0) {  
          Aleatorio();
          shape(quadrado, i*(lado+margem)-lado/2, -1*k*(lado+margem)-lado/2, lado, lado); //simetria
        }
        if ( k != 0 && i != 0) {
          Aleatorio();
          shape(quadrado, i*(lado+margem)-lado/2, k*(lado+margem)-lado/2, lado, lado); //simetria
        }
      }
      contador2 = contador2 - 2; //alterar número para dar outros efeitos
    }
  }
}

void Aleatorio() { //escolhe aleatoriamente o svg a apresentar

  int aleatorio = (int)random(1, 5);
  if (aleatorio == 1)
    quadrado = quadrado1;
  else if (aleatorio == 2)
    quadrado = quadrado2;
  else if (aleatorio == 3)
    quadrado = quadrado3;        
  else if (aleatorio == 4)
    quadrado = quadrado4;        
  else if (aleatorio == 5)
    quadrado = quadrado5;
}

void analisa() {

  maxBat = arrayVals[0];
  minBat = arrayVals[0];

  for (int i = 1; i < arrayVals.length; i++) {
    if (arrayVals [i] > maxBat) {

      maxBat = arrayVals[i];
    }

    if (arrayVals [i] < minBat) {  
      minBat = arrayVals[i];
    }
  }
}





