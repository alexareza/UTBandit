class Instructions {
  // arrays for twinkling stars - all code with twinkling stars was referenced from
  // the following source: https://openprocessing.org/sketch/76969/
  float[] xStarPos = new float[250];
  float[] yStarPos = new float[250];
  float[] xStarVel = new float[250];
  float[] yStarVel = new float[250];
  float[] sStar = new float[250]; 
  // variables for twinkling stars
  int a = 0;
  int b = 0;
  int c = 100;
  int p = 10;
  // loading variables for start screen
  PImage bg = loadImage("roomfloor.jpeg");
 PFont font = createFont("arcade2.ttf",50);
  PFont grassFont;
  float ytextPos = height / 2;
  ButtonToggle button;
  
  Instructions() {
    twinklingStars();
    imageMode(CENTER);
    textAlign(CENTER, CENTER);
    grassFont = createFont("grassfont.ttf", 150);
    bg.resize(200,200);
    button = new ButtonToggle(width/2, 300, 300, 70, "Instructions");
  }
  
    
  void show() {
    tileSize = 200;
    float xPos = 0;
    float yPos = 0;
    // Calculate number of tiles needed in each direction
    int numHorizontalTiles = width / tileSize;
    int numVerticalTiles = height / tileSize;
    for (int y = 0; y < numVerticalTiles +1; y++) {
      for (int x = 0; x < numHorizontalTiles +1; x++) {
        // Calculate position of the current tile
        xPos =  (x * tileSize);
        yPos =  (y * tileSize);
        image(bg, xPos, yPos, tileSize, tileSize);
      }
    }

    tracker();
    for (int i=0; i < 250; i++) {
      noStroke();
      ellipse(xStarPos[i], yStarPos[i], sStar[i], sStar[i]);
    }

    fill(#6EF77C);
    textFont(grassFont);
    textSize(90);
    textAlign(CENTER);
    text("I N S T R U C T I O N S", width / 2, height/7);
    
    color c = color(5, 95);
    fill(c);
    rect(width/2, height -350, 930, 600, 20);
    
    textFont(font);
    fill(255);
    textAlign(CENTER);
    textSize(20);
    text("EACH CIRCLE ON THE MAP IS A BUILDING. ENTER\nEACH ONE, DEFEAT THE ENEMIES, & COLLECT THE\nKEY! ONCE YOU HAVE COLLECTED EVERY KEY, \nYOU CAN ENTER AND CONQUER THE UT TOWER!", width /2, height/4);
    textSize(25);
    
    text("WASD TO MOVE", width /2, height - 450);
    text("POINT + CLICK TO SHOOT", width / 2, height - 400);
    text("PRESS 1 TO RESET", width /2, height - 350);
    text("COLLECT POWERUPS", width /2, height - 300);
    text("SURVIVE", width /2, height - 250);
    text("BEAT YOUR HIGH SCORE!", width /2, height - 200);
    
    
    
  }

  void twinklingStars() {
    for (int i=0; i < 250; i++) {
      xStarPos[i] =  random(1, width);
      yStarPos[i] = random(1, height);
      xStarVel[i] = random(-10, 10); // Adjust the range for slower movement
      yStarVel[i] = random(-10, 10); // Adjust the range for slower movement
      sStar[i] = random(1,6);
    } 
  }

  void tracker() {
    smooth ();
    fill(#D1FFD6);
    noStroke ();
    line (a, b, c, a);
    a = a + 3;
    if (a == 600) {
      a = 0;
      c = c +100;
      b = b +100;
    }
    stroke (255);
  
    for (int i=0; i < 250; i++) {
  
      line (xStarPos[i]+p, yStarPos[i], xStarPos[i], yStarPos[i]);
      line (xStarPos[i], yStarPos[i]+p, xStarPos[i], yStarPos[i]);
      line (xStarPos[i], yStarPos[i], xStarPos[i]-p, yStarPos[i]);
      line (xStarPos[i], yStarPos[i], xStarPos[i], yStarPos[i]-p);
      if (a > yStarPos[i]-25) {
        p = 5;
      }
      if (a < yStarPos[i]+25) {
        p = 5;
      }
      if (a < yStarPos[i]-25) {
        p = 0;
      }
      if (a > yStarPos[i]+25) {
        p = 0;
      }
      i = i + 1;
    }
  }
}
