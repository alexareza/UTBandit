class StartScreen {
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
  PImage tower = loadImage("uttower.png");
  PFont grassFont;
  float ytextPos = height / 2;
  
  StartScreen() {
    twinklingStars();
    imageMode(CENTER);
    textAlign(CENTER, CENTER);
    grassFont = createFont("grassfont.ttf", 150);
    bg.resize(200,200);
    tower.resize(600,600);
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
    image(tower, width/2, height -120);
    textFont(grassFont);
    
    text("UT BANDIT", width / 2, height/6);
    textFont(gameFont);

    fill(255);
    textSize(50);
    float displacement = 20 * sin(TWO_PI * frameCount / 180);
  
    ytextPos = height -200 + displacement;
    color c = color(5, 90);
    fill(c);
    rect(width/2, ytextPos, 700, 80, 20);
    fill(255);
    text("Press Any Key to Start", width / 2, ytextPos);
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
