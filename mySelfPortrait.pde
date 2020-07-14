size(400, 400);
background(100, 150, 255); // sets the background to blue
noStroke();

// draws the grass
fill(0, 200, 70);
rect(0, 300, 400, 100);
ellipse(200, 300, 500, 100);

// draws the sun
fill(255, 255, 0);
ellipse(250, 50, 50, 50);

// draws the head
fill(150, 100, 50);
ellipse(200, 200, 150, 200);

// draws the hair
fill(0);
ellipse(200, 120, 110, 50);

// draws the eyes
int eyeX1, eyeX2, eyeY;
eyeX1 = 150;
eyeY = 175;
eyeX2 = eyeX1 + 60;

fill(255, 255, 255);
ellipse(eyeX1, eyeY, 50, 25);
ellipse(eyeX2, eyeY, 50, 25);

fill(0, 0, 0);
ellipse(eyeX1, eyeY, 25, 25);
ellipse(eyeX2, eyeY, 25, 25);

// draws the eyebrows
eyeX1 -= 25;
eyeX2 = eyeX1 + 60;
eyeY -= 20;
stroke(0);
strokeWeight(4);
line(eyeX1, eyeY, eyeX1 + 40, eyeY);
line(eyeX2, eyeY, eyeX2 + 40, eyeY);

// draws the mouth
noStroke();
fill(0);
ellipse(200, 250, 70, 50);
fill(150, 100, 50);
ellipse(200, 247, 70, 50);

// draws the nose
stroke(0);
strokeWeight(2);
line(180, 210, 170, 230);
line(170, 230, 180, 238);

// draws the neck
noStroke();
fill(150, 100, 50);
rect(170, 280, 50, 70);

// draws the shirt
fill(200, 200, 200);
rect(100, 320, 190, 100);

// draws the clouds
fill(255, 255, 255, 100);
ellipse(100, 50, 150, 40);
ellipse(100, 40, 100, 40);
ellipse(120, 40, 120, 40);
