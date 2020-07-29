int firstSensor = 0;    // first analog sensor
int secondSensor = 0;   // second analog sensor
int inByte = 0;         // incoming serial byte

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect
  }

  establishContact();

  pinMode(7, INPUT);
  pinMode(4, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  if (Serial.available() > 0) {
    inByte = Serial.read();
    // read the digital inputs
    if (digitalRead(7) == LOW) firstSensor = 1;
    secondSensor = digitalRead(4);

    // send sensor values:
    Serial.print(firstSensor);
    Serial.print(",");
    Serial.print(secondSensor);
  }
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("0,0");   // send an initial string
    delay(300);
  }
}
