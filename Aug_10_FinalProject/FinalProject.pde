// Ball
Ball b;
float ballSpeed;


// Paddles
final float paddleSpeed = 20; // keeps speed of the paddle constant
Paddle p1, p2;

// Score variables
int p1Score, p2Score;

void setup() {
  fullScreen(); // creates a full screen canvas
  background(0); // sets the background to black
  frameRate(60); // sets the frame rate

  /*
   Ball Constructor Format
   Ball(float x, float y, float speed, float size, color fillColor)
   */
  ballSpeed = 20;
  b = new Ball(width / 2, height / 2, ballSpeed, 50, color(255, 0, 0));

  /*
   Paddle Constructor Format
   Paddle(float x, float y, float speed, float pHeight, float pWidth, color fillColor)
   */
  p1 = new Paddle(0, height / 2 - (height / 6), paddleSpeed, height / 3, width / 50, color(255, 200));
  p2 = new Paddle(width - width / 50, height / 2 - (height / 6), paddleSpeed, height / 3, width / 50, color(255, 200));

  p1Score = 0;
  p2Score = 1;
}

void draw() {
  background(0); // resets the background to black

  // draws the ball
  b.draw();

  // draws the paddles
  p1.draw();
  p2.draw();

  // checks ball collisions with the walls or the paddle
  checkCollisions();
}

void keyPressed() {
  // check presses for paddle movement
  if (key == 'w') p1.setUp(true);
  if (key == 's') p1.setDown(true);
  if (key == 'o') p2.setUp(true);
  if (key == 'l') p2.setDown(true);
}

void keyReleased() {
  // check key releases for paddle movement
  if (key == 'w') p1.setUp(false);
  if (key == 's') p1.setDown(false);
  if (key == 'o') p2.setUp(false);
  if (key == 'l') p2.setDown(false);
}

// checks if the paddle collides with the ball
void checkCollisions() {
  /*
  // check if the ball collides with p1
   if (b.y >= p1.y && b.y <= p1.y + p1.pHeight) {
   // checks if the ball successfully contacts p1
   if (b.x - b.radius <= p1.x + p1.pWidth) {
   b.setXSpeed(-b.xSpeed);
   p1Score++;
   }
   }
   
   // check if the ball collides with p2
   if (b.y >= p2.y && b.y <= p2.y + p2.pHeight) {
   // checks if the ball successfully contacts p2
   if (b.x + b.radius >= p2.x) {
   b.setXSpeed(-b.xSpeed);
   p2Score++;
   }
   }
   */

  // ALTERNATE APPROACH
  if (b.x - b.radius <= p1.x + p1.pWidth) {
    if (b.y >= p1.y && b.y <= p1.y + p1.pHeight) {
      b.setXSpeed(-b.xSpeed);
      p1Score++;
    } else {
      // check if ball goes off right side
      p1Score = 0;
      b = new Ball(width / 2, height / 2, ballSpeed, 50, color(255, 0, 0));
      b.setXSpeed(-b.xSpeed);
      //print("********RIGHT********"); // DEBUGGING
    }
  }

  if (b.x + b.radius >= p2.x) {
    if (b.y >= p2.y && b.y <= p2.y + p2.pHeight) {
      b.setXSpeed(-b.xSpeed);
      p2Score++;
    } else {
      // check if ball goes off left side
      p2Score = 0;
      b = new Ball(width / 2, height / 2, ballSpeed, 50, color(255, 0, 0));
      //print("********LEFT*********"); // DEBUGGING
    }
  }
}
