int analogInVal = 0;
int outputVal = 0;

void setup() {
  // put your setup code here, to run once:
  pinMode(9, OUTPUT); 
  pinMode(A2, INPUT); 
  pinMode(13, OUTPUT); 
  pinMode(8, INPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
  
  // read analog in value
  analogInVal = analogRead(A2);
  // map it to the rane of analog out
  outputVal = map(analogInVal, 0, 1023, 0, 255);
  // change analog out value
  analogWrite(9, outputVal);

  if (digitalRead(8) == HIGH) {
    // change the digital out pin value to HIGH
    digitalWrite(13, HIGH);
  } else {
    // change the digital out pin value to LOW
    digitalWrite(13, LOW);
  }
}
