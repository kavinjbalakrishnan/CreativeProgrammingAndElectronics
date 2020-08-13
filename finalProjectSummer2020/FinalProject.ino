// button variables
int inByte = 0;

// pin variables
const int YELLOW = A3;
const int GREEN = A1;
const int RED = A2;
const int BLUE = A0;

void setup() {
  // start serial port at 9600 bps and wait for port to open:
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  // buttons are on these pins
  pinMode(YELLOW, INPUT);
  pinMode(GREEN, INPUT);
  pinMode(RED, INPUT);
  pinMode(BLUE, INPUT);

  establishContact();  // send a byte to establish contact until receiver responds
}

void loop() {
  // if we get a valid byte, read analog ins:
  if (Serial.available() > 0) {
    // get incoming byte:
    inByte = Serial.read();

    // print pin values:
    Serial.print(analogRead(BLUE));
    Serial.print(",");
    Serial.print(analogRead(GREEN));
    Serial.print(",");
    Serial.print(analogRead(RED));
    Serial.print(",");
    Serial.println(analogRead(YELLOW));
  }
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("0,0,0,0");   // send an initial string
    delay(300);
  }
}
