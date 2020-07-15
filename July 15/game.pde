/*
creating ball class based on http://www.openprocessing.org/sketch/48960
 */
class Ball {
  float x, y, xSpeed, ySpeed, size;

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
final int ballSize = 10;

float paddleX, paddleY, paddleWidth, paddleHeight; // parameters for paddle
int score; // variable to keep track of user score
Ball b;

float xSpeed, ySpeed; // speed of the ball

void setup() {
  size(200, 200);
  noStroke();

  // initializes paddle parameters
  paddleX = mouseX;
  paddleY = height - 10;
  paddleHeight = 10;
  paddleWidth = 50;

  // constructs the ball;
  xSpeed = 5;
  ySpeed = 5;
  b = new Ball(width / 2, height / 2, xSpeed, ySpeed, ballSize);

  // constructs font
  PFont f = createFont("monaco", 12);
  textFont(f, 32);
}

void draw() {
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

void updatePaddle() {
  fill(255);
  rect(paddleX, paddleY, paddleWidth, paddleHeight); // draws the paddle
  paddleX = mouseX;

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
      score++; // increments score
    }
  } else if (b.y + r > paddleY) {
    score = 0; // resets score
    b.reset(width / 2, height / 2, xSpeed, ySpeed);
  }
}

// changes the color of the ball depending on the score
void determineBallColor() {
  fill(255, 0, 0);
  if (score < 15) fill(255, 255, 0);
  if (score < 10) fill(0, 255, 0);
  if (score < 5) fill(0, 0, 255);
}
