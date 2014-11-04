import processing.serial.*;
int diametro, margem, heartbeat;
float inByte;
int beat;
Serial myPort; 


void setup() {
  size(640,480);
  diametro = 20;
  margem = 4;
  heartbeat = 1;
  smooth();
  //frameRate(8); //para ajustar depois conforme a velocidade que se pretenda
   
  println(Serial.list());
  // I know that the first port in the serial list on my mac
  // is always my  Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  //myPort = new Serial(this, Serial.list()[0], 115200);
  myPort = new Serial(this, "/dev/tty.usbserial-A9005bkU", 115200); // Serial.list()[0], 115200);
  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');
  
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
  
  int yaxis = beat; //valores que alteram a cor nos eixos x e y
  //int contador1 = yaxis;
  //int contador2 = 9 - yaxis; // 9 para este exemplo com random até 8
  int contador1 = beat;
  int contador2 = beat;
  
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

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
  
  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to an int and map to the screen height:
    inByte = float(inString);
    inByte = map(inByte, 350, 650, 0, 9);
    beat = (int)inByte;
    println(beat);

    }
  }

