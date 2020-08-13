class Paddle {
  // Variables
  public float x, y, speed, pHeight, pWidth;
  public boolean up, down;
  public color fillColor;

  // Constructor
  Paddle(float x, float y, float speed, float pHeight, float pWidth, color fillColor) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.pHeight = pHeight;
    this.pWidth = pWidth;
    up = false;
    down = false;
    this.fillColor = fillColor;
  }

  // Functions

  // updates paddle's y coordinate
  void update() {
    // checks if the paddle is moving up or down (can't have both)
    if (up && !down) y -= speed;
    if (!up && down) y += speed;
  }

  // checks if paddle collides with wall
  void checkCollisions() {
    if (y < 0) y = 0;
    if (y + pHeight > height) y = height - pHeight;
  }

  // setter method for updating up (use when collecting inputs)
  void setUp(boolean up) {
    this.up = up;
  }

  // setter method for updating down (use when collecting inputs)
  void setDown(boolean down) {
    this.down = down;
  }

  // draws the paddle
  void draw() {
    update();
    checkCollisions();
    noStroke();

    // draw the paddle
    fill(fillColor);
    rect(x, y, pWidth, pHeight);
  }

  /*
   draws the paddle without updating it's position
   called when game is paused (mode == PAUSE)
   */
  void drawWithoutUpdate() {
    noStroke();

    // draw the paddle
    fill(fillColor);
    rect(x, y, pWidth, pHeight);
  }
}
