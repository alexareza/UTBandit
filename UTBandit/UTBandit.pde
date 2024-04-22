PImage backgroundImage;
Player player;

EndScreen endScreen;
StartScreen startScreen;
ScoreBoard scoreBoard;

boolean[] roomsCompleted = {false, false, false, false, false, false};

int roomTracker;
Room rooms[];
Room room;

ButtonToggle pma;
ButtonToggle gdc;
ButtonToggle stad;
ButtonToggle mc;
ButtonToggle pcl;
ButtonToggle tower;

ButtonToggle exit;
int s = 25;

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


void setup() {
  size(1000, 800);
  imageMode(CENTER);
  background(181,222,186);
  backgroundImage = loadImage("map2.png");
  // Resize map image to fit canvas size
  backgroundImage.resize(width, height);
  
  // generate a random room for each room
  rooms = new Room[6];
  for (int i = 0; i < 6; i++) {
    rooms[i] = new Room();
  }
  
  //tower = new ButtonToggle(x, y, s, "Tower")
  pma = new ButtonToggle(360, 165, s, s, "PMA");
  gdc = new ButtonToggle(370, 420, s, s, "GDC");
  stad = new ButtonToggle(583, 411, s, s, "STADIUM");
  mc = new ButtonToggle(685, 625, s, s, "MOODY CENTER");
  pcl = new ButtonToggle(275, 525, s, s, "PCL");
  tower = new ButtonToggle(217, 381, 28, 28, "TOWER");
  
  player = new Player();
  enemies = new ArrayList<Enemy>();
  bullets = new ArrayList<Bullet>();
  enemiesToRemove = new ArrayList<Enemy>();
  bulletsToRemove = new ArrayList<Bullet>();
  powerups = new ArrayList<Powerup>();
  endScreen = new EndScreen();
  startScreen = new StartScreen();
  scoreBoard = new ScoreBoard();
}

void draw() {
  switch (gameState) {
    case NOT_STARTED:
      startScreen.show();
      break;
    case STARTED:
      image(backgroundImage,width/2,height/2);
      player.show();
      checkRoomChosen();
      break;
    case LOST:
      endScreen.show_loss();
      endScreen.show_scoreBoard(scoreBoard);
      break;
    case WON:
      endScreen.show_win(timePlayed);
      scoreBoard.saveScore(timePlayed);
      endScreen.show_scoreBoard(scoreBoard);
      break;
  }
  
  // Check if game should be lost/won
  //boolean WIN_CONDITION = false; // TODO: Change this to be correct win condition
  boolean LOSE_CONDITION = player.health <= 0;
  
  if (checkGameWon() && gameState != WON) {
    int timePlayed = (millis() - startTime);
    println();
    println(timePlayed);
    println();
    gameState = WON;
    scoreBoard.saveScore(timePlayed);
  } else if (LOSE_CONDITION && gameState != LOST) {
    gameState = LOST;
  }
}

void mousePressed() {
  // detect if a button has been pressed
  float buttonDistanceThreshold = 35; 
  
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

  if ((gameState == WON || gameState == LOST) && mouseX > width/2 - 75 && mouseX < width/2 + 75 && mouseY > height/2 + 75 && mouseY < height/2 + 125) { 
    resetGame();
  } else {
    player.onMousePressed(); // Call the onMousePressed method of the Player class
  }
}


void keyPressed() {
  if (gameState == NOT_STARTED) {
    resetGame();
  } else {
    // Reset game if '1' key is pressed
    if (key == '1') {
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
  if (gdc.state) {
    roomTracker = 0;
    if (checkRoomCompleted(roomTracker) == true) {
      
      gdc.state = false;
    }
  } else if (pma.state) {
    roomTracker = 1;
    if (checkRoomCompleted(roomTracker) == true) {
      pma.state = false;
    }
  
  } else if (stad.state) {
    //println("room stad");
    roomTracker = 2;
    if (checkRoomCompleted(roomTracker) == true) {
      stad.state = false;
    }

  } else if (mc.state) {
    //println("room mc");
    roomTracker = 3;
    if (checkRoomCompleted(roomTracker) == true) {
      mc.state = false;
    }

  } else if (pcl.state) {
    roomTracker = 4;
    if (checkRoomCompleted(roomTracker) == true) {
      pcl.state = false;
    }
  } else if (tower.state) {
    for (int i = 0; i < 5; i++) {
      if (!roomsCompleted[i]) {
        //return false; // If any of the first five rooms is not completed, return false
      }
    }
    roomsCompleted[5] = true; 
    
  } else {
    //println("room null");
    room = null; 
  }
    // only show buttons if we are not inside a room
  if (room != null && !keyCollected) {
    room.display();
    player.update_position();
    player.show();
    levels.levelBehavior();
   
  } else {
    room = null;
    background(181,222,186);
    
    image(backgroundImage, width/2, height/2);
    
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
  enemies.clear();
  bullets.clear();
  powerups.clear();
  gameState = STARTED;
  timePlayed = 0;
  keys = null; // Reset the key
  loop();
}

void restartGame() {
  player = new Player();
  enemies.clear();
  bullets.clear();
  powerups.clear();
  gameState = NOT_STARTED;
  timePlayed = 0;
  keys = null; // Reset the key
  startTime = millis();
  loop();
}

void keyReleased() {
  player.onKeyReleased();
}

void mouseMoved() {
  player.onMouseMoved();
}
