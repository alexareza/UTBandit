class Room {
    int roomMinWidth = 500;
    int roomMaxWidth = 900;
    int roomMinHeight = 600;
    int roomMaxHeight = 800;
    int roomX, roomY, roomWidth, roomHeight;  
    PImage roomTexture;
    PImage cave;
    float boxX;
    float boxY;
    PImage floorTexture; 
    PImage outsideTexture;
    int tileSize = 100; // Size of each tile
    PFont font = createFont("arcade2.ttf",50);
    int enemiesDied;
    float roomLeftBound;
    float roomRightBound;
    float roomTopBound;
    float roomBottomBound;
    
  Room() {
    rectMode(CENTER);
    imageMode(CENTER);
    generateRoom();
    floorTexture = loadImage("roomfloor.jpeg");
    outsideTexture = loadImage("outside.jpg");
    outsideTexture.resize(200,200);
    floorTexture.resize(100,100);
    exit = new ButtonToggle(60, 95, s*3, s *1.5, "exit");
  }

  void display() {
    //player.position = new PVector(width/2,height/2);
    imageMode(CENTER);
    // draw room graphics
    rectMode(CENTER);
    drawOutside();
    drawRoomTexture(floorTexture);

    // room border 
    stroke(30); 
    strokeWeight(7); 
    noFill();
    rect(width/2, height/2, roomWidth, roomHeight);
    initializeGame();
  }
  
  void initializeGame() {
    // show exit button
    exit.show();
    textSize(14);
    textAlign(CENTER, CENTER);
    fill(255);
    text("EXIT", 62, 96);
    strokeWeight(2);
    
    // if the exit button is pressed
    if (exit.state) {

      pma.state = false;
      gdc.state = false;
      stad.state = false;
      mc.state = false;
      pcl.state = false;

      levels.enemiesSpawned = false;

      room = null;
      player.position = new PVector(width/3,height/2);
      keys = null; // Reset the key
      exit.state = false;
    } 
    checkRoomCompleted();
    updateEntities();
    if (player.health <= 0) {
      gameState = LOST;
    }
    if (gameState == LOST) {
    //if (gameState == WON || gameState == LOST) {
      
      endScreen.show();
      endScreen.show_loss();
      endScreen.show_scoreBoard(scoreBoard);
      player.position = new PVector(-10,-10);
      noLoop(); 
      return; 
    }
    
    int currentTime = millis();    
    if (currentTime - lastTime >= interval) {
      difficulty += .5;
      lastTime = millis();
    }
     
      
    if (enemies.isEmpty() && keys == null) {
      // Create a key
      keys = new Keys();
    } 
  
    // Display the key if it exists
    if (keys != null) {
      keys.display();
      keys.keySprite.nextFrame();      
    } else {
      if (currentTime - lastPowerupTime >= powerupSpawnInterval) {
        float centerX = width/2;
        float centerY = height/2;
        float boxX = room.roomWidth / 2;
        float boxY = room.roomHeight / 2;
        powerups.add(new Powerup(random(centerX - boxX + 10, centerX + boxX) -10, random(centerY - boxY +10, centerY + boxY - 10)));
        lastPowerupTime = currentTime;
      }
    
      for (int i = powerups.size() - 1; i >= 0; i--) {
        Powerup powerup = powerups.get(i);
        powerup.display();
        powerup.powerupSprite.nextFrame(); 
        
        if (powerup.collidesWithPlayer(player)) {
          player.increaseBulletCount();
          powerups.remove(i);
        }
      }
    }
    displayStats();
  }
  
  void displayStats() {
    // Display player health and score
    rectMode(CORNER);
    fill(255);
    stroke(255);
    strokeWeight(2);
    float bar = map(50, 0, 100, 0, width - 40);
    rect(20, 20, bar, 20);
    
    // changing health bar according to health
    float healthBarWidth = map(player.health, 0, 100, 0, width - 40);
    strokeWeight(1);
    fill(255, 0, 0);
    rect(20, 20, healthBarWidth, 20);
    textFont(font);
    
    // display text for health bar/stats
    textSize(14);
    textAlign(LEFT); 
    fill(255);
    float percentage_health = (float(player.health) / 50) * 100;
    
    text(nf(percentage_health, 0, 0)+ "%", 22, 38);
    text("Time Played: " + ((millis() - startTime) /1000) + " sec", 20, 60);
    text("Difficulty Multiplier: x" + difficulty, 512, 38);
  }
  
  void generateRoom() {
    roomWidth = int(random(roomMinWidth, roomMaxWidth));
    roomHeight = int(random(roomMinHeight, roomMaxHeight));
    roomWidth = round(roomWidth / tileSize) * tileSize;
    roomHeight = round(roomHeight / tileSize) * tileSize;
    
    boxX = roomWidth / 2;
    boxY = roomHeight / 2;
    
    roomLeftBound = width / 2 - roomWidth / 2;
    roomRightBound = width / 2 + roomWidth / 2;
    roomTopBound = height / 2 - roomHeight / 2;
    roomBottomBound = height / 2 + roomHeight / 2;
  }
  
  
  void checkRoomCompleted() {
    // Check for collision with the key
    if (keys != null && keys.collidesWithPlayer(player)) {
      
      buttons[roomTracker].setFillColor(color(#C93D3D));
      keyCollected = true;
      updateTracker();
      pma.state = false;
      gdc.state = false;
      stad.state = false;
      mc.state = false;
      pcl.state = false;
      //image(backgroundImage,width/2,height/2);
      levels.increaseLevel();
      //resetGame();
      room = null;
      keys = null; // Reset the key
    } 
  }
  
  void updateTracker() {
  // Check the label of the button and update the corresponding boolean value
    switch(roomTracker) {
      case 0:
        roomsCompleted[0] = true; 
        break;
      case 1:
        roomsCompleted[1] = true; // Set GDC room completed to true
        break;
      case 2:
        roomsCompleted[2] = true; // Set STADIUM room completed to true
        break;
      case 3:
        roomsCompleted[3] = true; // Set MOODY CENTER room completed to true
        break;
      case 4:
        roomsCompleted[4] = true; // Set PCL room completed to true
        break;
      default:
        break;
     }
  }
  
  void updateEntities() {
    
    for (Bullet bullet : bullets) {
      bullet.update();
      bullet.display();
    }
    
    for (Enemy enemy: enemies) {

      enemy.update(enemies); // Update enemy position
      enemy.display();
      
      if (enemy.hits(player)) {
        player.health -= enemy.damageAmt * 0.1;
        enemiesDied += 1;
        enemiesToRemove.add(enemy);
      }
    }
    
    // Remove enemies and bullets
    for (Bullet bullet : bullets) {
      for (Enemy enemy : enemies) {
        if (bullet.hits(enemy)) {
          bulletsToRemove.add(bullet);
          enemy.health -= 10; // Reduce enemy's health by 10
          if (enemy.health <= 0) { // Check if the enemy is dead
            enemiesToRemove.add(enemy); // Remove the dead enemy
            player.score++; // Increase player's score for killing the enemy
          }
          break; 
        }
      }
    }

    enemies.removeAll(enemiesToRemove);
    enemiesToRemove.clear();
    
    // Make sure that enemies that collided with the player respawn, preventing an "easy win" where player lets enemies hit player in early levels
    for (int i = 0; i < enemiesDied; i++) {
      int levelHealth = levels.determineHealth();
      enemies.add(new Enemy(levelHealth, 10));
    }
    enemiesDied = 0;
    bullets.removeAll(bulletsToRemove);
    bulletsToRemove.clear();
  }
  
  void drawRoomTexture(PImage texture) {
    tileSize = 100;
    imageMode(CORNER);
    // Calculate  number of images needed 
    int numHorizontalTiles = room.roomWidth / tileSize;
    int numVerticalTiles = room.roomHeight / tileSize;
    // Draw tiles row by row
    for (int y = 0; y < numVerticalTiles; y++) {
      for (int x = 0; x < numHorizontalTiles; x++) {
        
        float xPos = width/2 - boxX + (x * tileSize);
        float yPos = height/2 - boxY + (y * tileSize);
        image(texture, xPos, yPos, tileSize, tileSize);
      }
    }
  }
  
  void drawOutside() {
    imageMode(CENTER);
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
        image(outsideTexture, xPos, yPos, tileSize, tileSize);
      }
    }
  }
  
  float getBoxX() {
    return boxX;
  }
  
  float getBoxY() {
    return boxY;
  }
}
