
const int numReadings =5;

int bat = 0;
int ECG = A0;
int batold = 0;
int bat2 = 0;
int batMax = 0;
int batMin = 1023;
int batMed = 0;
float beat = 0.00;


int indexc = 0;
int batOld = 0;
//indice de estabilizaç~o de sinal


int readings[numReadings];      // the readings from the analog input
int index = 0;                  // the index of the current reading
int total = 0;                  // the running total
int average = 0;                // the average



int treshold;
long int lastTime;
int timeall = millis();
void setup() {
  // initialize the serial communication:
  Serial.begin(115200);
//  Serial.print(":::::::::::::::GET READY::::::::::::::::");
  delay (2000);
  timeall = millis();
  calibra();
//  Serial.print("    MINIMO :");
//  Serial.println(batMin);
//   Serial.print("    MAXIMO :");
//  Serial.println(batMax);
  
//  calculateTres();
//  timeall = millis();
//  detectBeat();
//  float ppm1 = beat/1000;
//  Serial.println(ppm1);
//  float ppm = 60/ppm1;
//  int PPM = float(ppm);
//  Serial.print("    PULSAÇOES POR MIN :");
//  Serial.println(PPM);
for (int thisReading = 0; thisReading < numReadings; thisReading++)
    readings[thisReading] = 0;   

}

void loop() {
  total= total - readings[index];    
  readings[index] = analogRead(ECG);
  //readings[index] = map(bat, batMin,batMax, 0,100);
  
  total= total + readings[index];       

  index = index + 1; 
  
  if (index >= numReadings) {             
    // ...wrap around to the beginning: 
    index = 0;                           

  // calculate the average:
  average = total / numReadings;         
  // send it to the computer as ASCII digits
  Serial.println(average);   
  delay(1);        // delay in between reads for stability            
}

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
//
//void detectBeat() {
//  int count = 0;
//  while (millis() < 6000+timeall) {
//    bat = analogRead(ECG);
//    int time = millis();
//    if (bat > batMax - treshold && bat < batMax + treshold && indexc <=index) {
//      readings[indexc] = time - lastTime;
//      lastTime = time;
//      indexc++;
//      Serial.println(time-lastTime);
//    }
//
//    delay(2);
//  }
//  for (int i = 0; i <=index; i++){
//
//    beat = beat + readings[i];}
//
//  
//  beat = beat/(index+1);
//  Serial.print("BEAT DETECTION: ");
//  Serial.println(beat);
//}
//
//
//void calculateTres() {
//
//  const int factor1 = 80;
//  treshold = (batMax - batMin) / factor1;
//  Serial.print("      TRES: ");
//  Serial.println(treshold);
//
//
//}
