size(500, 500);

// initializes color pallete
color background = #6bc1ff;
color skin = #b08046;
color shirt  = #ffffff;
color pants = #375680;
color grass = #64bd3a;
color treeTrunk = #805b25;
color treeLeaves = #12a339;
color sun = #ffea00;

noStroke();
background(background); // sets the background color

// sun
fill(sun);
ellipse(width - width / 4, height / 6, width / 6, width / 6);

// grass
fill(grass);
rect(0, height - height / 3, width, height / 3);

// left tree
float treeX = width / 5, treeY = height - height / 2, treeWidth = width / 15, treeHeight = height / 3;
float leavesSize = width / 4;
fill(treeTrunk);
rect(treeX, treeY, treeWidth, treeHeight); // tree trunk
fill(treeLeaves);
ellipse(treeX + treeWidth / 2, treeHeight + treeHeight / 3, leavesSize, leavesSize); // tree leaves

// right tree
fill(treeTrunk);
treeX = width - width / 5;
rect(treeX, treeY, treeWidth, treeHeight); // tree trunk
fill(treeLeaves);
ellipse(treeX + treeWidth / 2, treeHeight + treeHeight / 3, leavesSize, leavesSize); // tree leaves

// head
fill(skin);
float headSize = 50, headX = width / 2, headY = height / 2 - 50;
ellipse(headX, headY, headSize, headSize);

// body
fill(shirt);
float bodyX = headX, bodyY = headY + headSize / 2 + 55, bodyWidth = 66, bodyHeight = 100;
rectMode(CENTER);
rect(bodyX, bodyY, bodyWidth, bodyHeight);

// left arm
fill(shirt);
float armWidth = 10, armHeight = bodyHeight - armWidth;
float armX = bodyX - bodyWidth / 2 - armWidth, armY = bodyY;
rect(armX, armY, armWidth, armHeight);
ellipse(armX, armY - armHeight / 2, armWidth, armWidth); // shoulder 
fill(skin);
ellipse(armX, armY + armHeight / 2, armWidth, armWidth); // hand

// right arm
fill(shirt);
armX = bodyX + bodyWidth / 2 + armWidth;
rect(armX, armY, armWidth, armHeight);
ellipse(armX, armY - armHeight / 2, armWidth, armWidth); // shoulder
fill(skin);
ellipse(armX, armY + armHeight / 2, armWidth, armWidth); // hand

// sculpts the torso
fill(background);
float shoulderY = bodyY - bodyHeight / 2;
float leftOuterHipX = bodyX - bodyWidth / 2;
float leftInnerHipX = leftOuterHipX + 10;
float hipY = bodyY + bodyHeight / 2;
triangle(leftOuterHipX, shoulderY, leftInnerHipX, hipY, leftOuterHipX, hipY); // left waist

float rightOuterHipX = bodyX + bodyWidth / 2;
float rightInnerHipX = rightOuterHipX - 10;
triangle(rightOuterHipX, shoulderY, rightInnerHipX, hipY, rightOuterHipX, hipY); // right waist

// legs
fill(pants);
rectMode(CORNER);
float legsX = leftInnerHipX, legsY = hipY + 5, legsWidth = rightInnerHipX - leftInnerHipX, legsHeight = 125;
rect(legsX, legsY, legsWidth, legsHeight);

// sculpts the legs
fill(grass);
triangle(legsX, legsY, legsX + 10, legsY + legsHeight, legsX, legsY + legsHeight); // left leg
triangle(legsX + legsWidth, legsY, legsX + legsWidth - 10, legsY + legsHeight, legsX + legsWidth, legsY + legsHeight); // right leg
