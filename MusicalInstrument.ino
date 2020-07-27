#include <Servo.h>

#include "pitches.h"

/*
  imported from adafruit website
  https://learn.adafruit.com/multi-tasking-the-arduino-part-1?view=all
*/

class Sweeper
{
    Servo servo;              // the servo
    int pos;              // current servo position
    int increment;        // increment to move for each interval
    int  updateInterval;      // interval between updates
    unsigned long lastUpdate; // last update of position

  public:
    Sweeper(int interval)
    {
      updateInterval = interval;
      increment = 1;
    }

    void Attach(int pin)
    {
      servo.attach(pin);
    }

    void Detach()
    {
      servo.detach();
    }

    void setUpdateInterval(int n) {
      updateInterval = n;
    }

    void Update()
    {
      if ((millis() - lastUpdate) > updateInterval) // time to update
      {
        lastUpdate = millis();
        pos += increment;
        servo.write(pos);
        if ((pos >= 180) || (pos <= 0)) // end of sweep
        {
          // reverse direction
          increment = -increment;
        }
      }
    }
};

// notes for each switch
int notes[] = {NOTE_CS6, NOTE_FS5, NOTE_GS5, NOTE_A5};

// switch pins
int note1Pin = A1, note2Pin = A2, note3Pin = A3, note4Pin = A4;

// speaker pin
int speakerPin = 8;

// initialize sweeper
Sweeper sweeper(10);

// initialize potentiometer Pin
int potentiometerPin = A0;

void setup() {
  // put your setup code here, to run once:

  // attach the servo to pin 9
  sweeper.Attach(9);
}

void loop() {
  // put your main code here, to run repeatedly:

  // check to see if a switch is on
  // only one switch can be on at a time
  if (digitalRead(note1Pin)) {
    tone(speakerPin, notes[0]);
  } else if (digitalRead(note2Pin)) {
    tone(speakerPin, notes[1]);
  } else if (digitalRead(note3Pin)) {
    tone(speakerPin, notes[2]);
  } else if (digitalRead(note4Pin)) {
    tone(speakerPin, notes[3]);
  } else {
    noTone(speakerPin);
  }

  // update the servo
  int potentiometerVal = analogRead(potentiometerPin);
  sweeper.setUpdateInterval(map(potentiometerVal, 0, 1023, 1, 25)); 
  sweeper.Update();

}
