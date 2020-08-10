class Ball {
  // Variables
  public float x, y, xSpeed, ySpeed, speed, size, glowOffset, glowSpeed, glowThreshold, radius;
  public color fillColor;

  // Constructor
  Ball(float x, float y, float speed, float size, color fillColor) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    xSpeed = speed;
    ySpeed = speed;
    this.size = size;
    this.fillColor = fillColor; 
    glowOffset = 0;
    glowSpeed = speed / 5;
    glowThreshold = 5 * size;
    radius = size / 2;
  }

  // Functions

  // updates ball's x and y coordinates
  void update() {
    x += xSpeed;
    y += ySpeed;

    glowOffset += glowSpeed; // update the ball's glow
  }

  // checks if ball collides with the wall
  void checkCollisions() {
    // if the ball collides with the wall, reverse the direction
    
    /*
     if (x < radius) xSpeed = -xSpeed;
     if (x + radius > width) xSpeed = -xSpeed;
     */
     
    if (y < radius) ySpeed = -ySpeed;
    if (y + radius > height) ySpeed = -ySpeed;

    // if the glowOffset reaches a threshold, reverse the direction
    if (glowOffset > glowThreshold) glowSpeed = - glowSpeed;
    if (glowOffset < 0) glowSpeed = - glowSpeed;
  }

  // setter method for updating speed
  void setSpeed(float speed) {
    // get the sign of xSpeed and ySpeed (1 or -1)
    xSpeed /= this.speed;
    ySpeed /= this.speed;

    // multiply the sign by the new speed
    xSpeed *= speed;
    ySpeed *= speed;
  }

  // setter method for updating xSpeed
  void setXSpeed(float xSpeed) {
    this.xSpeed = xSpeed;
  }

  // draws the ball
  void draw() {
    update();
    checkCollisions();
    noStroke();

    // draw the ball's glow
    fill(255, map(glowOffset, 0, glowThreshold, 100, 0)); // 2nd parameter is the "alpha" value
    ellipse(x, y, size + glowOffset, size + glowOffset);

    // draw the fall
    fill(fillColor);
    ellipse(x, y, size, size);
  }
}
