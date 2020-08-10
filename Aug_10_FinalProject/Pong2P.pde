/* 
 This is a 2 player game of pong. Each player controls a paddle which is used to hit the ball. If the player is unable to 
 hit the ball before it leaves the screen, then the opposing player gains a point and the ball resets. The speed of the 
 ball increases as the game progresses. The first player to reach 10 points wins.
 */

// game mode variables
final int START = 0;
final int PAUSE = 1;
final int PLAY = 2;
final int END = 3;
int mode;

// paddle variables
Paddle p1, p2;
final float paddleWidth = 15;
final float paddleHeight = 200;
final float paddleSpeed = 5;

// ball variables
Ball[] balls = new Ball[5];
final float ballStartSpeed = 5;
final float speedIncrease = .001;
final float ballSize = 20;
int ballsInPlay = 0;

// movement variables
boolean p1Up, p1Down, p2Up, p2Down;

// font
PFont f;

void setup() {
  size(1000, 800); // set canvas size
  background(0); // set background

  mode = START; // set game mode

  // set font
  f = createFont("courier new", 12);
  textFont(f, 32);
  textAlign(CENTER);
}

void draw() {
  background(0);
  display(mode);
}

// gets user key presses
void keyPressed() {
  switch(key) {
  case 'w':
    if (mode == PLAY) p1.moveUp();
  case 's':
    if (mode == PLAY) p1.moveDown();
  case 'o':
    if (mode == PLAY) p2.moveUp();
  case 'l':
    if (mode == PLAY) p2.moveUp();
  }
}

// COMMENTED FOR DEBUGGING
//// gets user key releases
//void keyReleased() {
//  switch(key) {
//  case 'w':
//    p1Up = false;
//  case 's': 
//    p1Down = false;
//  case 'o':
//    p2Up = false;
//  case 'l':
//    p2Down = false;
//  }
//}

// gets user key strokes
void keyTyped() {
  switch(key) {
  case 'p':
    if (mode == START) mode = PLAY;
    else if (mode == PAUSE) mode = PLAY;
    else mode = PAUSE;
    break;
  case 's':
    if (mode == END) mode = START;
    if (mode == PAUSE) mode = START;
  case 'b':
  }
}

// displays canvas every frame
void display(int mode) {
  switch(mode) {
  case START:
    reset();
    text("Press 'P' to start and to pause\nP1 use 'W' to move up and 'S' to move down\nP2 use 'O' to move up and 'L' to move down", width / 2, height / 2);
    break;
  case PAUSE:
    p1.draw();
    p2.draw();
    for (int i = 0; i < 5; i++) {
      balls[i].draw();
    }
    text("Press 'P' to play", width / 2, height / 2);
    break;
  case PLAY: 
    text("P1 Score: " + p1.score + "\nP2 Score: " + p2.score, width / 2, height / 2);
    updateBalls();
    updatePaddles();
  case END:
    break;
  }
}

// resets all variables and values to their initial positions
void reset() {
  // set paddle
  p1 = new Paddle(0, paddleWidth, paddleHeight, paddleSpeed);
  p2 = new Paddle(width - paddleWidth, paddleWidth, paddleHeight, paddleSpeed);

  // set balls
  for (int i = 0; i < 5; i++) {
    balls[i] = new Ball(width / 2, height / 2, ballStartSpeed, ballSize);
  }

  // set the first ball in play
  balls[1].setInPlay();
  ballsInPlay++;

  // set movement variables
  p1Up = false;
  p1Down = false;
  p2Up = false;
  p2Down = false;
}

// updates all balls and draws them
void updateBalls() {
  for (int i = 0; i < 5; i++) {
    balls[i].update();
    balls[i].checkCollisions();
    balls[i].draw();
  }
}

// updates both paddles and draws them
void updatePaddles() {
  // DEBUGGING PRINT STATEMENTS
  println(p1Up);
  println(p1Down);
  println(p2Up);
  println(p2Down);
  if (p1Up) p1.moveUp();
  if (p1Down) p1.moveDown();
  p1.checkCollisions();
  p1.draw();

  if (p2Up) p2.moveUp();
  if (p2Down) p2.moveDown();
  p2.checkCollisions();
  p2.draw();
}
