

int bat = 0;
int tres = 550;

int batims[800];

int batMax;
int batMin;
int Soma;

int ledPin = 11;

int ECG = A0;

void setup() {
  // initialize the serial communication:
  Serial.begin(115200);


  pinMode (ledPin, OUTPUT);
  digitalWrite (ledPin, LOW);
  delay (1000);
  getRefs();
  delay (1000);

}

void loop() {




  bat = analogRead(ECG);

  if (bat >= batMax) {
    analogWrite (ledPin, 250);

  }

  if (bat > Soma && bat < batMax) {
    analogWrite (ledPin, 100);

  }
  
    if (bat < Soma && bat > batMin) {
    analogWrite (ledPin, 20);

  }
     if (bat < batMin) {
    analogWrite (ledPin, 0);

  }


  Serial.println(bat);
  delay(1);





}


void getRefs () {

  int cicloMax = 800;



  delay(200);
  Serial.println(" coloque-se em posicao de repouso");
  delay (3000);

  for (int i = 0; i < cicloMax; i++) {
    batims[i] = analogRead(ECG);
    delay(1);
  }


  batMin = batims[0];
  batMin = batims[0];

  for (int l = 0; l < cicloMax; l++) {
    if (batims[l] > batMax) {
      batMax = batims[l];
    }

    if (batims[l] < batMin) {
      batMin = batims[l];
    }

    Soma = (Soma + batims[l]) / 2;


  }


  Serial.print("MAX = ");
  Serial.println(batMax);
  Serial.print("MIN = ");
  Serial.println(batMin);
  Serial.print("AVG = ");
  Serial.println(Soma);




}


