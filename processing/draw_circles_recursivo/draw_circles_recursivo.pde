import processing.serial.*;
int diametro, margem, heartbeat, lado;

Serial myPort; 
PShape quadrado, quadrado1, quadrado2, quadrado3, quadrado4, quadrado5;


void setup() {
  size(640,480);
  diametro = 20;
  lado = 20;
  margem = 4;
  heartbeat = 1;
  smooth();
  frameRate(8); //para ajustar depois conforme a velocidade que se pretenda
  quadrado1 = loadShape("quadrado.svg");
  quadrado2 = loadShape("quadrado2.svg");
  quadrado3 = loadShape("quadrado3.svg");
  quadrado4 = loadShape("quadrado4.svg");
  quadrado5 = loadShape("quadrado5.svg");
}
 
void draw() {
  background(255);
  translate(width/2, height/2); // coloca a coordenada (0,0) no centro do ecrã
  
  //código se a matriz for feita de círculos
  /*for (int i = 0; i <= (height/2 - diametro/2 - margem); i = (i + diametro + margem))
    drawCircle(0,i,diametro);
  for (int i = 0; i >= (-1*height/2 + diametro/2 + margem); i = (i - diametro - margem))
    drawCircle(0,i,diametro);*/
    
  for (int i = 0; i <= (height/2 - lado/2 - margem); i = (i + lado + margem))
    drawRect(0-lado/2,i-lado/2,lado);
  for (int i = 0; i >= (-1*height/2 + lado/2 + margem); i = (i - lado - margem))
    drawRect(0-lado/2,i-lado/2,lado);
  
  fillRect(); 

}
 
void drawCircle(float x, float y, float diam) { //função que desenha a matriz de círculos
  stroke(0);
  noFill();
  ellipse(x, y, diam, diam);
  ellipse(-1*x, y, diam, diam);
  if(x - diam - margem > -1*width/2 + diam/2 + margem){
    drawCircle(x - diam - margem, y, diam);  
  }
}

void drawRect(float x, float y, float side) { //função que desenha a matriz de rectângulos
  stroke(0);
  noFill();
  rect(x, y, side, side);
  if(-1*x + side + margem < width/2 - margem){
    rect(-1*x + margem, y, side, side);
  }
  if(x - side - margem > -1*width/2 + margem){
    drawRect(x - side - margem, y, side);  
  }
}

void fillCircle() { //função que pinta os círculos
  fill(0);
  int yaxis = (int)random(1,8); //valores que alteram a cor nos eixos x e y
  //int contador1 = yaxis;
  //int contador2 = 9 - yaxis; // 9 para este exemplo com random até 8
  int contador1 = yaxis; //(int)random(1,8);
  int contador2 = yaxis; //(int)random(1,8);
  
  if (yaxis > 4){ // eixo y maior
    for (int k = 0; k <= 9 - yaxis; k++){
      for (int i = 0; i <= contador1; i++){ //pinta eixo y
        if (heartbeat == 20) {
          fill(255);
          heartbeat = 0;
        }
        else {
          fill(0);
          heartbeat++;
        }
          
        ellipse(-1*k*(diametro+margem),-1*i*(diametro+margem),diametro,diametro);
        ellipse(k*(diametro+margem),-1*i*(diametro+margem),diametro,diametro); //simetria
        ellipse(-1*k*(diametro+margem),i*(diametro+margem),diametro,diametro); //simetria
        ellipse(k*(diametro+margem),i*(diametro+margem),diametro,diametro); //simetria
      } 
      contador1 = contador1 - 2; //alterar número para dar outros efeitos
    }
  }
  else { // eixo x maior
    for (int k = 0; k <= 9 - yaxis; k++){
      for (int i = 0; i <= contador2; i++){ //pinta eixo y
        ellipse(-1*i*(diametro+margem),-1*k*(diametro+margem),diametro,diametro);
        ellipse(-1*i*(diametro+margem),k*(diametro+margem),diametro,diametro); //simetria
        ellipse(i*(diametro+margem),-1*k*(diametro+margem),diametro,diametro); //simetria
        ellipse(i*(diametro+margem),k*(diametro+margem),diametro,diametro); //simetria
      }
      contador2 = contador2 - 2; //alterar número para dar outros efeitos
    }
  }
      
}

void fillRect() { //função que pinta os círculos
  fill(0);
  int yaxis = (int)random(1,8); //valores que alteram a cor nos eixos x e y
  //int contador1 = yaxis;
  //int contador2 = 9 - yaxis; // 9 para este exemplo com random até 8
  int contador1 = yaxis; //(int)random(1,8);
  int contador2 = yaxis; //(int)random(1,8);
  
  if (yaxis > 4){ // eixo y maior
    for (int k = 0; k <= 9 - yaxis; k++){
      for (int i = 0; i <= contador1; i++){ //pinta eixo y
        if (heartbeat == 20) {
          fill(255);
          heartbeat = 0;
        }
        else {
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
        shape(quadrado, -1*k*(lado+margem)-lado/2,-1*i*(lado+margem)-lado/2,lado,lado);
        if (k != 0){  
          Aleatorio();
          shape(quadrado, k*(lado+margem)-lado/2,-1*i*(lado+margem)-lado/2,lado,lado); //simetria
        }
        if (i != 0){  
          Aleatorio();
          shape(quadrado, -1*k*(lado+margem)-lado/2,i*(lado+margem)-lado/2,lado,lado); //simetria
        }
        if ( k != 0 && i != 0){
          Aleatorio();
          shape(quadrado, k*(lado+margem)-lado/2,i*(lado+margem)-lado/2,lado,lado); //simetria
        }
      } 
      contador1 = contador1 - 2; //alterar número para dar outros efeitos
    }
  }
  else { // eixo x maior
    for (int k = 0; k <= 9 - yaxis; k++){
      for (int i = 0; i <= contador2; i++){ //pinta eixo y
      
        // código para pintar quadrados
        //rect(quadrado, -1*i*(lado+margem)-lado/2,-1*k*(lado+margem)-lado/2,lado,lado);
        //rect(quadrado, -1*i*(lado+margem)-lado/2,k*(lado+margem)-lado/2,lado,lado); //simetria
        //rect(quadrado, i*(lado+margem)-lado/2,-1*k*(lado+margem)-lado/2,lado,lado); //simetria
        //rect(quadrado, i*(lado+margem)-lado/2,k*(lado+margem)-lado/2,lado,lado); //simetria
      
      
      
      
      
        // código para carregar svgs
        Aleatorio();
        shape(quadrado, -1*i*(lado+margem)-lado/2,-1*k*(lado+margem)-lado/2,lado,lado);
        if (k != 0){ 
          Aleatorio();
          shape(quadrado, -1*i*(lado+margem)-lado/2,k*(lado+margem)-lado/2,lado,lado); //simetria
        }
        if (i != 0){  
          Aleatorio();
          shape(quadrado, i*(lado+margem)-lado/2,-1*k*(lado+margem)-lado/2,lado,lado); //simetria
        }
        if ( k != 0 && i != 0){
          Aleatorio();
          shape(quadrado, i*(lado+margem)-lado/2,k*(lado+margem)-lado/2,lado,lado); //simetria
        }
      }
      contador2 = contador2 - 2; //alterar número para dar outros efeitos
    }
  }
      
}

void Aleatorio() { //função que desenha a matriz de círculos

        int aleatorio = (int)random(1,5);
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
