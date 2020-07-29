import processing.serial.*;

import processing.sound.*;

/*
creating ball class based on http://www.openprocessing.org/sketch/48960
 */
class Ball {
  // variables
  float x, y, xSpeed, ySpeed, size;

  // constructor
  Ball(float x, float y, float xSpeed, float ySpeed, float size) {
    this.x = x;
    this.y = y;
    this.xSpeed= xSpeed;
    this.ySpeed = ySpeed;
    this.size = size;
  }

  // periodically increases the speed of the ball
  void updateSpeed(float a) {
    if (xSpeed < 0) xSpeed -= a;
    else xSpeed += a;
    if (ySpeed < 0) ySpeed -=a;
    else ySpeed += a;
  }

  // updates the ball every frame
  void update() {
    x += xSpeed;
    y += ySpeed;
    checkCollisions();
    draw();
  }

  // resets the ball's position and speed
  void reset(float x, float y, float xSpeed, float ySpeed) {
    this.x = x;
    this.y = y;
    this.xSpeed= xSpeed;
    this.ySpeed = ySpeed;
  }

  // checks to see if the ball contacts the wall
  void checkCollisions() {
    float r = size / 2;
    if (x < r ||x + r > width) xSpeed = -xSpeed;
    if (y < r || y > height - r) ySpeed = -ySpeed;
  }

  void draw() {
    ellipse(x, y, size, size);
  }
}

final int ballSize = 20;
final float paddleSpeed = 5; // used for speed of the paddle

float paddleX, paddleY, paddleWidth, paddleHeight; // parameters for paddle
int score; // variable to keep track of user score
Ball b;

float xSpeed, ySpeed; // speed of the ball

// game modes
final int START = 0;
final int PAUSE = 1;
final int PLAY = 2;
int mode;

// sound file
SoundFile beep;

// paddle states
boolean moveRight = false, moveLeft = false;

void setup() {
  size(500, 500);
  frameRate(120);
  noStroke();

  // initializes paddle parameters
  paddleX = mouseX;
  paddleY = height - 10;
  paddleHeight = 15;
  paddleWidth = 100;


  // constructs the ball;
  xSpeed = 5;
  ySpeed = 5;
  b = new Ball(width / 2, height / 2, xSpeed, ySpeed, ballSize);

  // constructs font
  PFont f = createFont("courier new", 12);
  textFont(f, 20);

  mode = START; // sets game mode

  // load sound file from /data folder
  beep = new SoundFile(this, "beep.wav"); // open source sound library
}

void draw() {
  if (mode == PLAY) {
    background(0); // sets the background to black
    updatePaddle();

    // displays the score
    textAlign(CENTER);
    text(score, width / 2, height / 2);

    determineBallColor();
    // updates the ball
    b.update();
    b.updateSpeed(0.001);
  }

  if (mode == START) {
    score = 0; // resets score
    b.reset(width / 2, height / 2, xSpeed, ySpeed);
    background(0);
    textAlign(CENTER);
    text("Press 'P' to start and to pause", width / 2, height / 2);
  }

  if (mode == PAUSE) {
    background(0);
    drawPaddle();
    b.draw();
    text("Press 'P' to play", width / 2, height / 2);
  }
}

void keyTyped() {
  switch (key) {
  case 'p':
    if (mode == START) mode = PLAY;
    else if (mode == PLAY) mode = PAUSE;
    else if (mode == PAUSE) mode = PLAY;
    break;
  }
}

// draws the paddle
void drawPaddle() {
  fill(255);
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
}

// updates and draws the paddle
void updatePaddle() {
  fill(255);
  rect(paddleX, paddleY, paddleWidth, paddleHeight); // draws the paddle

  if (moveRight) {
    paddleX = paddleX + paddleSpeed;
  } else if (moveLeft) {
    paddleX = paddleX - paddleSpeed;
  }

  // prevents the paddle from going off the screen
  if (paddleX < 0) paddleX = 0;
  if (paddleX > width - paddleWidth) paddleX = width - paddleWidth;

  checkBallCollision(b);
}

void checkBallCollision(Ball b) {
  float r = b.size / 2; // stores the radius of the ball in r

  // checks to see if the ball is in contact with the paddle
  if (b.x + r > paddleX && b.x - r < paddleX + paddleWidth) {
    if (b.y + r >= paddleY) {
      b.ySpeed = -b.ySpeed;
      beep.play();
      score++; // increments score
    }
  } else if (b.y + r > paddleY) {
    mode = START;
  }
}

// changes the color of the ball depending on the score
void determineBallColor() {
  fill(255, 0, 0);
  if (score < 15) fill(255, 255, 0);
  if (score < 10) fill(0, 255, 0);
  if (score < 5) fill(0, 0, 255);
}

// serialEvent method is run automatically by the Processing applet whenever
// the buffer reaches the  byte value set in the bufferUntil()
// method in the setup():
void serialEvent(Serial myPort) {
  // read the serial buffer:
  String myString = myPort.readStringUntil('\n');
  // if you got any bytes other than the linefeed:
  myString = trim(myString);

  // split the string at the commas and convert the sections into integers:
  int sensors[] = int(split(myString, ','));

  // print out the values you got:
  for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
    print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t");
  }
  // add a linefeed after all the sensor values are printed:
  println();
  if (sensors.length > 1) {
    if (sensors[0] == 1) {
      moveLeft = true;
      moveRight = false;
    } else if (sensors[1] == 1) {
      moveLeft = false;
      moveRight = true;
    } else {
      moveLeft = false;
      moveRight = false;
    }
  }
  // send a byte to ask for more data:
  myPort.write("A");
}
