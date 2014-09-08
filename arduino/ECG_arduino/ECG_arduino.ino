#include <math.h>

int bat = 0;
int tres = 550;

int batims[800];

int batMax = 0;

int ledPin = 13;

int ECG = A0;

void setup() {
  // initialize the serial communication:
  Serial.begin(115200);
  delay(200);
  Serial.println(" coloque-se em posicao de repouso");
  delay (3000);
  
  pinMode (ledPin, OUTPUT);
  
  for (int i = 0; i < 800; i++) {
    batims[i] = analogRead(ECG);
    if (batims[i] > batMax && i != 0 ) {
      batMax = batims[i];
    }
    else {
      if (i !=0){
    batMax = batims[i-1];}
      if (i==0){
        batMax = batims[i];
      }
    }
    delay(1);
  }
  
   Serial.println(batMax);
   delay (300);
   tres = batMax;
   Serial.println(tres);
}
 

  void loop() {
    bat = analogRead(ECG);





    if (bat > batMax) {
      digitalWrite (ledPin, HIGH);
     

    }

    else {
      digitalWrite (ledPin, LOW);
    }







    Serial.println(bat);

    delay(1);
  }

