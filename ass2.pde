float x = 300;
float y = 300;
float direction = 0;
float increment = 1;
float speed = 5;
int score = 0;
boolean gameOver = false;
float warpRadius = 100;

float[] coorWarp = new float[2];
float[][] coorStars = new float [100][2];
float[] craftPos = new float [2];

void coorStars() {
  for (int a = 0; a <= 99; a = a + 1) {
    coorStars[a][0] = random(0, 600);
    coorStars[a][1] = random(0, 600);
  }
}

void stars() {
  stroke(255);
  for (int b = 0; b <= 99; b = b + 1) {
    point(coorStars[b][0], coorStars[b][1]);
    //println(coorStars[b][0]);
  }
}

// Collision detection
boolean warp(float[] warpPos) {
  boolean flag;
  //Using some mathematics to find distance between with the craft and the warp
  if ((sqrt(pow((warpPos[0] - craftPos[0]), 2)) + sqrt(pow((warpPos[1] - craftPos[1]),2))) <= float(50 + 10)) {
    flag = true;
  } else {
    flag = false;
  }
  return flag;
}

// Collision detectoin for black hole
boolean collision(float coorx, float coory) {
  boolean flag;
  if((sqrt(pow((coorx - craftPos[0]), 2)) + sqrt(pow((coory - craftPos[1]), 2))) <= float(20 + 10)) {
    flag = true;
  } else {
    flag = false;
  }
  return flag;
}

void blackHoleAt(float HoleX, float HoleY) {
  //strokeWeight(2);
  noFill();
  ellipse(HoleX, HoleY, 40, 40);
  if (collision(HoleX, HoleY)) {
    gameOver = true;
  }
}

float[] createWarp() {
  float[] tempCoor = new float[2];
  tempCoor[0] = random(0, width);
  tempCoor[1] = random(0, height);
  
  return tempCoor;
}

void score(int userScore) {
  String filler = "";
  
  // Hard reset just like the original game :)
  if (userScore == 9999) {
    userScore = 0;
  }
  
  for (int i = str(userScore).length(); i < 4; i++) {
    filler += "0";
  }
  text("Score: " + filler + userScore, 5, (height - 5));
}

float[] craft() {
  x = x + speed * cos(direction);
  y = y + speed * sin(direction);
  direction = direction + increment * 0.03;
  
  // Wrapping for the craft
  if (x > width) {
    x = x - width;
  }
  if (x < 0) {
    x = width - x;
  }
  if (y > height) {
    y = y - height;
  }
  if (y < 0) {
    y = height - y;
  }
  
  craftPos[0] = x;
  craftPos[1] = y;
  
  return craftPos;
}

void setup() {
  size(600,600);
    coorStars();
  // Create the inital warp
  coorWarp = createWarp();
}

//Change directions
void keyPressed() {
  if (key == 'w' || key == 's' || key == 'a' || key == 'd') {
    if (key == 'w') {
      for (int c = 0; c <= 99; c = c + 1) {
        coorStars[c][1] = coorStars[c][1] + 1;
      }
    }
    if (key == 's') {
      for (int d = 0; d <= 99; d = d + 1) {
        coorStars[d][1] = coorStars[d][1] - 1;
      }
    }
    if (key == 'a') {
      for (int e = 0; e <= 99; e = e + 1) {
        coorStars[e][0] = coorStars[e][0] - 1;
      }
    }
    if (key == 'd') {
      for (int f = 0; f <= 99; f = f + 1) {
        coorStars[f][0] = coorStars[f][0] + 1;
      }
    }
  } else {
    increment = increment * -1;
  }
}

void draw() {
  background(0);
  stars();
  blackHoleAt(100, 40);
  blackHoleAt(400,500);
  // Detecting warp collision and craft, it also calculates the craft position and draws it
  if (gameOver) {
    textSize(20);
    text("Game Over" ,height/2,width/2);
  } else {
    craft();
  }
  fill(255);
  ellipse(craftPos[0], craftPos[1], 20, 20);
  if (warp(coorWarp)) {
    coorWarp = createWarp();
    score +=1;
    coorStars();
  }
  // Draw warp
  wormHole();
  score(score);
}

void wormHole() {
  stroke(255);
  fill(255);
  ellipse(coorWarp[0], coorWarp[1], warpRadius, warpRadius);
  warpRadius = warpRadius - 1;
  if (warpRadius <= -100) {
    warpRadius = 100;
  }
}
  
  
  
