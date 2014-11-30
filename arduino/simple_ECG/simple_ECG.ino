

int bat = 0;
int ECG = A0;
int batold = 0;
int bat2 = 0;
int batMax = 0;
int batMin = 1023;
int batMed = 0;
float beat = 0.00;
const int index = 30;
int readings[index];
int indexc = 0;
//indice de estabilizaç~o de sinal

int treshold;
long int lastTime;
int timeall = millis();
void setup() {
  // initialize the serial communication:
  Serial.begin(115200);
  Serial.print(":::::::::::::::GET READY::::::::::::::::");
  delay (2000);
  timeall = millis();
  calibra();
  Serial.print("    MINIMO :");
  Serial.println(batMin);
   Serial.print("    MAXIMO :");
  Serial.println(batMax);
  
  calculateTres();
  timeall = millis();
  detectBeat();
  float ppm1 = beat/1000;
  Serial.println(ppm1);
  float ppm = 60/ppm1;
  int PPM = float(ppm);
  Serial.print("    PULSAÇOES POR MIN :");
  Serial.println(PPM);


}

void loop() {

  bat = analogRead(ECG);
//  if (bat > batMax - treshold && bat < batMax + treshold){
//  
//  Serial.println("PUM");
//  
//  
//  }


}


void calibra() {

  while (millis() < 6000+timeall) {
    bat = analogRead(ECG);
    if (bat < batMin) {
      batMin = bat;
    }
    if (bat > batMax) {
      batMax = bat;
    }
    delay(1);
  }

}

void detectBeat() {
  int count = 0;
  while (millis() < 6000+timeall) {
    bat = analogRead(ECG);
    int time = millis();
    if (bat > batMax - treshold && bat < batMax + treshold && indexc <=index) {
      readings[indexc] = time - lastTime;
      lastTime = time;
      indexc++;
      Serial.println(time-lastTime);
    }

    delay(2);
  }
  for (int i = 0; i <=index; i++){

    beat = beat + readings[i];}

  
  beat = beat/(index+1);
  Serial.print("BEAT DETECTION: ");
  Serial.println(beat);
}


void calculateTres() {

  const int factor1 = 80;
  treshold = (batMax - batMin) / factor1;
  Serial.print("      TRES: ");
  Serial.println(treshold);


}
