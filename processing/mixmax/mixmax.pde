import processing.serial.*;
int diametro, margem, heartbeat;

Serial myPort; 


void setup() {
  size(640,480);
  diametro = 20;
  margem = 4;
  heartbeat = 1;
  smooth();
  frameRate(8); //para ajustar depois conforme a velocidade que se pretenda
}
 
void draw() {
  background(255);
  translate(width/2, height/2); // coloca a coordenada (0,0) no centro do ecrã
  for (int i = 0; i <= (height/2 - diametro/2 - margem); i = (i + diametro + margem))
    drawCircle(0,i,diametro);
  for (int i = 0; i >= (-1*height/2 + diametro/2 + margem); i = (i - diametro - margem))
    drawCircle(0,i,diametro);
  
  fillCircle(); 

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

void fillCircle() { //função que pinta os círculos
  fill(0);
  int yaxis = (int)random(1,8); //valores que alteram a cor nos eixos x e y
  //int contador1 = yaxis;
  //int contador2 = 9 - yaxis; // 9 para este exemplo com random até 8
  int contador1 = (int)random(1,8);
  int contador2 = (int)random(1,8);
  
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
