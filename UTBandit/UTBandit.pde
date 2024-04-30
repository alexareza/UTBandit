import processing.sound.*;

// DEBUGGING MODE
//boolean[] roomsCompleted = {true, true, true, true, true, false};

// REGULAR USER MODE
boolean[] roomsCompleted = {false, false, false, false, false, false};

PImage backgroundImage;
PImage grassTexture;
int tileSize = 200;
PFont gameFont;

Player player;
Instructions instructions;
EndScreen endScreen;
StartScreen startScreen;
ScoreBoard scoreBoard;


Room rooms[];
Room room;
ButtonToggle gdc;
ButtonToggle pma;
ButtonToggle stad;
ButtonToggle mc;
ButtonToggle pcl;
ButtonToggle tower;
ButtonToggle exit;
ButtonToggle exitGame;
ButtonToggle howTo;
ButtonToggle back;
ButtonToggle[] buttons;

int roomTracker;
boolean roomComplete = false;
boolean keyCollected = false;
Keys keys;
Levels levels = new Levels();
Sprite keySprite;
Sprite powerupSprite;

ArrayList<Enemy> enemies;
ArrayList<Bullet> bullets;
ArrayList<Enemy> enemiesToRemove;
ArrayList<Bullet> bulletsToRemove;
ArrayList<Powerup> powerups;

float boxX;
float boxY;

int s = 25;
int enemySpawnInterval = 1000; 
int lastSpawnTime = 0;
float difficulty = 1;
int lastTime = 0;
int interval = 10000;
int lastPowerupTime = 0;
int powerupSpawnInterval = 7000;
int level = 1;
int bulletCount = 1;

final int NOT_STARTED = 0; // Not started
final int STARTED = 1; // Started, currently running
final int LOST = 2; // Game over, game lost
final int WON = 3; // Game over, game won

int gameState = NOT_STARTED;
int startTime;
int timePlayed;

SoundFile powerupSound;
SoundFile shootingSound;
SoundFile keySound;
SoundFile gameOverSound;
SoundFile gameWonSound;
SoundFile gameSound;


void setup() {
  size(1000, 800);
  imageMode(CENTER);
  gameFont = createFont("arcade.ttf", 40);
  textFont(gameFont);
  backgroundImage = loadImage("map.png");
  grassTexture = loadImage("grass.jpg");

  // Resize map image to fit canvas size
  backgroundImage.resize(width, height);
  
  // generate a random room for each room
  rooms = new Room[6];
  for (int i = 0; i < 6; i++) {
    rooms[i] = new Room();
  }
  // create all buttons, arrays, screens, sounds
  gdc = new ButtonToggle(370, 420, s, s, "GDC");
  pma = new ButtonToggle(360, 165, s, s, "PMA");
  stad = new ButtonToggle(583, 411, s, s, "STADIUM");
  mc = new ButtonToggle(685, 625, s, s, "MOODY CENTER");
  pcl = new ButtonToggle(275, 525, s, s, "PCL");
  tower = new ButtonToggle(217, 381, 28, 28, "TOWER");
  howTo = new ButtonToggle(width/2, 300, 300, 70, "Instructions");
  back = new ButtonToggle(width/2, height-140, 150, 70, "BACK");
  buttons = new ButtonToggle[]{gdc, pma, stad, mc, pcl};
  exitGame = new ButtonToggle(60, 60, s*3, s *1.5, "exitGame");
  player = new Player();
  
  enemies = new ArrayList<Enemy>();
  bullets = new ArrayList<Bullet>();
  enemiesToRemove = new ArrayList<Enemy>();
  bulletsToRemove = new ArrayList<Bullet>();
  powerups = new ArrayList<Powerup>();
  
  endScreen = new EndScreen();
  startScreen = new StartScreen();
  scoreBoard = new ScoreBoard();
  instructions = new Instructions();

  // sound
  gameSound = new SoundFile(this, "gamesound.mp3");
  powerupSound = new SoundFile(this, "powerup.mp3");
  shootingSound = new SoundFile(this, "shooting.mp3");
  keySound = new SoundFile(this, "keySound.mp3");
  gameOverSound = new SoundFile(this, "gameover.mp3");
  gameWonSound = new SoundFile(this, "gamewon.mp3");
  Sound.volume(.03);
  gameSound.loop();
  gameSound.play();
}

void draw() {
  rectMode(CENTER);
  switch (gameState) {
    case NOT_STARTED:
      startScreen.show();
      howTo.show();
      if (howTo.state) {
        instructions.show();
        back.show();
        fill(255);
        
        text("BACK",width/2, height-140);

      }
      if (back.state) {
        howTo.state = false;
        back.state = false;
      }
      break;
    case STARTED:
      player.show();
      checkRoomChosen();
      break;
    case LOST:
      endScreen.show();
      endScreen.show_loss();
      endScreen.show_scoreBoard(scoreBoard);
      break;
    case WON:
      endScreen.show_win(timePlayed);
      endScreen.show_scoreBoard(scoreBoard);
      break;
  }
  
  // Check if game should be lost/won
  boolean LOSE_CONDITION = player.health <= 0;
  
  if (checkGameWon() && gameState != WON) {
    
    timePlayed = (millis() - startTime);
    scoreBoard.saveScore(timePlayed);
    gameState = WON;
  } else if (LOSE_CONDITION && gameState != LOST) {
    gameState = LOST;
  }
}

void mousePressed() {
  // detect if a button has been pressed
  float buttonDistanceThreshold = 35; 
  if (gameState == NOT_STARTED) {
    howTo.onMousePress();
    back.onMousePress();
  }
  
  // check the distance between the player and each button before allowing the click action
  if (dist(player.position.x, player.position.y, gdc.x, gdc.y) < buttonDistanceThreshold) {
    gdc.onMousePress();
  }
  
  if (dist(player.position.x, player.position.y, stad.x, stad.y) < buttonDistanceThreshold) {
    stad.onMousePress();
  }
  
  if (dist(player.position.x, player.position.y, pma.x, pma.y) < buttonDistanceThreshold) {
    pma.onMousePress();
  }
  
  if (dist(player.position.x, player.position.y, mc.x, mc.y) < buttonDistanceThreshold) {
    mc.onMousePress();
  }
  if (dist(player.position.x, player.position.y, pcl.x, pcl.y) < buttonDistanceThreshold) {
    pcl.onMousePress();
  }
  
  if (dist(player.position.x, player.position.y, tower.x, tower.y) < buttonDistanceThreshold) {
    tower.onMousePress();
  }
  
  exit.onMousePress();
  exitGame.onMousePress();
  if ((gameState == WON || gameState == LOST) && mouseX > width/2 - 100 && mouseX < width/2 + 100 &&
      mouseY > height/3 + 50 && mouseY < height/3 + 150) { 
    //room = null;
    
    rooms = new Room[6];
    for (int i = 0; i < 6; i++) {
      rooms[i] = new Room();
    }
    for (int i = 0; i < 6; i++) {
      roomsCompleted[i] = false;
    }
    restartGame();
    
  } else if (gameState != LOST) {
    
    player.onMousePressed(); // Call the onMousePressed method of the Player class
  }
}


void keyPressed() {
  if (!howTo.state) {
    if (gameState == NOT_STARTED) {
      resetGame();
    } else {
    
      player.onKeyPressed();
    }
  } 
}

boolean checkRoomCompleted(int roomNum) {
  if (roomsCompleted[roomNum] == false) {
      room = rooms[roomNum];
      return false;
   }
   return true; 
}

void checkRoomChosen() {
  if (exitGame.state) {
    rooms = new Room[6];
    for (int i = 0; i < 6; i++) {
      rooms[i] = new Room();
    }
     for (int i = 0; i < 6; i++) {
      roomsCompleted[i] = false;
    }
    exitGame.state = false;
    
    restartGame();
  }
  
  for (int i = 0; i < buttons.length; i++) {
    if (buttons[i].state) {
      roomTracker = i;
      if (checkRoomCompleted(roomTracker)) {
        buttons[i].setFillColor(color(#C93D3D));
        buttons[i].state = false;
      }
      break; // Exit the loop after handling one button
    }
  }

  if (tower.state) {
    boolean complete = true;
    for (int i = 0; i < 5; i++) {
      if (roomsCompleted[i] == false) {
        complete = false;
      }
    }
    if (complete) {
      roomsCompleted[5] = true; 
    }
  }
  // only show buttons if we are not inside a room
  if (room != null  && !keyCollected) {
    room.display();
    player.update_position();
    player.show();
    levels.levelBehavior();
   // we are on main map
  } else { 
    drawOutside();
    image(backgroundImage, width/2, height/2);
    fill(0);
    text("Time Played: " + ((millis() - startTime) /1000) + " sec", 150, 20);
    exitGame.show();
    fill(255);
    text("EXIT", 62, 60);
    pma.show();
    gdc.show();
    stad.show();
    mc.show();
    pcl.show();
    tower.show();
    player.update_position();
    player.show();
    keyCollected = false;
  } 
}

  

boolean checkGameWon() {
  for (boolean roomCompleted: roomsCompleted) {
    if (!roomCompleted) {
      return false;
    }
  }
  return true;  
}


void resetGame() {
  player = new Player();
  //enemies.clear();
  bullets.clear();
  powerups.clear();
  gameState = STARTED;
  keys = null; // Reset the key
  
  loop();
}

void restartGame() {
  imageMode(CENTER);
  rectMode(CENTER);
  
  for (int i = 0; i < buttons.length; i++) {
    buttons[i].state = false;
    buttons[i].setFillColor(color(172,88,33));
  }
  levels.currentLevel = 1;
  levels.resetGame();
  player = new Player();
  tower.state = false;
  bullets.clear();
  powerups.clear();
  gameState = NOT_STARTED;
  timePlayed = 0;
  keys = null; // Reset the key
  room = null;
  startTime = millis();
  loop();
}

void keyReleased() {
  player.onKeyReleased();
}

void mouseMoved() {
  player.onMouseMoved();
}

void drawOutside() {
  imageMode(CENTER);
  float xPos = 0;
  float yPos = 0;
  // calculate the number of images needed in each direction
  int numHorizontalTiles = width / tileSize;
  int numVerticalTiles = height / tileSize;
  // draw each image
  for (int y = 0; y < numVerticalTiles +1; y++) {
    for (int x = 0; x < numHorizontalTiles +1; x++) {
      // calculate the position of current tile
      xPos = x * tileSize;
      yPos = y * tileSize;
      image(grassTexture, xPos, yPos, tileSize, tileSize);
    }
  }
}
