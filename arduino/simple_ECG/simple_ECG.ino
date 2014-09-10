

int bat = 0;
int ECG = A0;

void setup() {
  // initialize the serial communication:
  Serial.begin(115200);


}

void loop() {




  bat = analogRead(ECG);


  Serial.println(bat);
  delay(1);





}





