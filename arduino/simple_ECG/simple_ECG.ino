

int bat = 0;
int ECG = A0;
int batold = 0;
int bat2 = 0;
int batMax = 0;
int batMin = 0;
int batMed = 0;

//indice de estabilizaç~o de sinal

const int threshEst = 150;

void setup() {
  // initialize the serial communication:
  Serial.begin(115200);
  inicia();

}

void loop() {




  bat = analogRead(ECG);
//  Serial.print ("bat: ");
//  Serial.println (bat);
  
  if (bat > batold - threshEst && bat < batold + threshEst){
    bat2 = batold;
   
  }
  
  else {
    bat2 = bat;
    batold = bat;
   }
   
  Serial.println(bat);
  
  delay(1);





}

void inicia() {
 bat = analogRead(ECG);

 batold = bat;
 bat2= bat;

}



