class Paddle {
  // variables
  public float x, y, speed, paddleWidth, paddleHeight;
  public int score;

  // constructor
  Paddle(float x, float paddleWidth, float paddleHeight, float speed) {
    this.x = x;
    this.speed = speed;
    this.paddleWidth = paddleWidth;
    this.paddleHeight = paddleHeight;
    y = height / 2 - paddleHeight / 2;
    score = 0;
  }

  // draws the paddle
  void draw() {
    rect(x, y, paddleWidth, paddleHeight);
  }

  // moves the paddle up
  void moveUp() {
    y = y - speed;
  }

  // moves the paddle down
  void moveDown() {
    y += speed;
  }

  // checks if the paddle collides with the edge of the canvas
  void checkCollisions() {
    // if the paddle collides with the edge of the canvas, prevent it from going off screen
    if (y < 0) y = 0;
    if (y + paddleHeight > height) y = height - paddleHeight;
  }
  
  // increments the score
  void increaseScore() {
    score++;
  }
}
