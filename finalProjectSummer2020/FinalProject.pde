import processing.serial.*;

import processing.sound.*;

// Ball
Ball b;
final float BALLSPEED = 20;

// Paddles
final float PADDLESPEED = 20; // keeps speed of the paddle constant
Paddle p1, p2;

// Player variables
int winner;
final int PLAYER1 = 1;
final int PLAYER2 = 2;

// Game state variables
int mode;
final int START = 1;
final int PLAY = 2;
final int PAUSE = 3;
final int END = 4;

// Sound
SoundFile beep;

// Serial port
Serial myPort;

void setup() {
  fullScreen(); // creates a full screen canvas
  background(0); // sets the background to black
  frameRate(60); // sets the frame rate

  /*
   Ball Constructor Format
   Ball(float x, float y, float speed, float size, color fillColor)
   */
  b = new Ball(width / 2, height / 2, BALLSPEED, 50, color(255, 0, 0));

  /*
   Paddle Constructor Format
   Paddle(float x, float y, float speed, float pHeight, float pWidth, color fillColor)
   */
  p1 = new Paddle(0, height / 2 - (height / 6), PADDLESPEED, height / 3, width / 50, color(0, 0, 255, 150));
  p2 = new Paddle(width - width / 50, height / 2 - (height / 6), PADDLESPEED, height / 3, width / 50, color(0, 255, 0, 150));

  // initilize game mode
  mode = START;
  winner = 0;

  // construct font
  PFont font = createFont("courier new", 12);
  textFont(font, 30);

  // load sound file from /data folder
  beep = new SoundFile(this, "beep.wav"); // from online open source sound library

  // List all the available serial ports
  // if using Processing 2.1 or later, use Serial.printArray()
  println(Serial.list());

  // I know that the first port in the serial list on my Mac is always my
  // Arduino board, so I open Serial.list()[0].
  // Change the 0 to the appropriate number of the serial port that your
  // microcontroller is attached to.
  myPort = new Serial(this, Serial.list()[1], 9600);

  // read bytes into a buffer until you get a linefeed (ASCII 10):
  myPort.bufferUntil('\n');
}

void draw() {
  switch(mode) {
  case START:
    background(0); // resets the background to black

    // draws the paddles
    p1.drawWithoutUpdate();
    p2.drawWithoutUpdate();

    // displays start message
    textAlign(CENTER);
    fill(255);
    text("Press 's' to start the game and 'p' to pause\nP1 use the red and the blue buttons\nP2 use the green and yellow buttons\nUse the potentiometer to control the ball speed", width / 2, height / 2);

    break;
  case PLAY:
    background(0); // resets the background to black

    // draws the ball
    b.draw();

    // draws the paddles
    p1.draw();
    p2.draw();

    // checks ball collisions with the walls or the paddle
    checkCollisions();

    break;
  case PAUSE:
    background(0); // resets the background to black

    // draws the ball
    b.drawWithoutUpdate();

    // draws the paddles
    p1.drawWithoutUpdate();
    p2.drawWithoutUpdate();

    // displays pause message
    textAlign(CENTER);
    fill(255);
    text("Press 'p' to play", width / 2, height / 2);

    break;
  case END:
    background(0); // resets the background to black

    // draws the paddles
    p1.drawWithoutUpdate();
    p2.drawWithoutUpdate();

    // display end message
    textAlign(CENTER);
    fill(255);
    if (winner == PLAYER1) {
      text("Player 1 wins!\nPress 's' to restart", width / 2, height / 2);
    } else if (winner == PLAYER2) {
      text("Player 2 wins!\nPress 's' to restart", width / 2, height / 2);
    }

    break;
  }
}

void keyTyped() {
  // check key strokes for game modes (state machine implementation)
  if (key == 's' && mode == START) mode = PLAY;
  if (key == 'p' && mode == PLAY) mode = PAUSE;
  else if (key == 'p' && mode == PAUSE) mode = PLAY;
  if (key == 's' && mode == END) mode = START;
}

void keyPressed() {
  /*
  // check presses for paddle movement
   if (key == 'w') p1.setUp(true);
   if (key == 's') p1.setDown(true);
   if (key == 'o') p2.setUp(true);
   if (key == 'l') p2.setDown(true);
   */
}

void keyReleased() {
  /*
  // check key releases for paddle movement
   if (key == 'w') p1.setUp(false);
   if (key == 's') p1.setDown(false);
   if (key == 'o') p2.setUp(false);
   if (key == 'l') p2.setDown(false);
   */
}

// checks if the paddle collides with the ball
void checkCollisions() {

  if (b.x - b.radius <= p1.x + p1.pWidth) {
    if (b.y >= p1.y && b.y <= p1.y + p1.pHeight) {
      // reverse the ball's direction
      b.setXSpeed(-b.xSpeed);
      beep.play(); // play sound
    } else {
      // check if ball goes off right side
      mode = END;
      winner = PLAYER2;
      b = new Ball(width / 2, height / 2, BALLSPEED, 50, color(255, 0, 0));
      b.setXSpeed(-b.xSpeed);
    }
  }

  if (b.x + b.radius >= p2.x) {
    if (b.y >= p2.y && b.y <= p2.y + p2.pHeight) {
      // reverse the ball's direction
      b.setXSpeed(-b.xSpeed);
      beep.play(); // play sound
    } else {
      // check if ball goes off left side
      mode = END;
      winner = PLAYER1;
      b = new Ball(width / 2, height / 2, BALLSPEED, 50, color(255, 0, 0));
    }
  }
}

void serialEvent(Serial myPort) {
  // read the serial buffer:
  String myString = myPort.readStringUntil('\n');
  // if you got any bytes other than the linefeed:
  myString = trim(myString);

  // split the string at the commas and convert the sections into integers:
  int sensors[] = int(split(myString, ','));

  /* // print out the values you got:
   for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
   print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t");
   }
   // add a linefeed after all the sensor values are printed:
   println();
   if (sensors.length > 1) {
   xpos = map(sensors[0], 0, 1023, 0, width);
   ypos = map(sensors[1], 0, 1023, 0, height);
   fgcolor = sensors[2];
   }*/

  // reset paddle booleans
  p1.setUp(false);
  p1.setDown(false);
  p2.setUp(false);
  p2.setDown(false);

  if (sensors[0] != 0) p1.setUp(true);
  if (sensors[1] != 0) p1.setDown(true);
  if (sensors[2] != 0) p2.setUp(true);
  if (sensors[3] != 0) p2.setDown(true);

  // send a byte to ask for more data:
  myPort.write("A");
}
