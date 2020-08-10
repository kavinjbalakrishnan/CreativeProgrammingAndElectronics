class Ball {
  // variables
  public float x, y, xSpeed, ySpeed, size;
  public boolean inPlay;

  // constructor
  Ball(float x, float y, float speed, float size) {
    this.x = x;
    this.y = y;
    xSpeed = speed;
    ySpeed = speed;
    this.size = size;
    inPlay = false;
  }

  void setInPlay() {
    inPlay = true;
  }

  // draws the ball
  void draw() {
    if (inPlay) ellipse(x, y, size, size);
  }

  // updates the ball's x and y position
  void update() {
    if (inPlay) {
      x += xSpeed;
      y += ySpeed;
    }
  }

  // checks if ball collides with the edge of the canvas
  void checkCollisions() {
    float radius = size / 2;

    // if the ball collides with the edge of the canvas, reverse the direction
    if (x - radius < 0) xSpeed = -xSpeed;
    if (x + radius > width) xSpeed = -xSpeed;
    if (y - radius < 0) ySpeed = -ySpeed;
    if (y + radius > height) ySpeed = -ySpeed;
  }

  // increases the ball's speed by a
  void increaseSpeed(float a) {
    if (inPlay) {
      xSpeed += a;
      ySpeed += a;
    }
  }
}
