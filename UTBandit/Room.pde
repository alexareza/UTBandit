class Room {
    int roomMinWidth = 400;
    int roomMaxWidth = 950;
    int roomMinHeight = 500;
    int roomMaxHeight = 800;
    int roomX, roomY, roomWidth, roomHeight;  
    PImage roomTexture;
    PImage cave;
    float boxX;
    float boxY;
    
  Room() {
    rectMode(CENTER);
    imageMode(CENTER);
    generateRoom();

    roomTexture = loadImage("floor3.jpeg");
    roomTexture.resize(roomWidth, roomHeight);
    cave = loadImage("cave_entrance.jpg");
    cave.resize(width, height);
    
    exit = new ButtonToggle(60, 95, s*3, s *1.5, "exit");
    
  }

  void display() {
    rectMode(CENTER);
    background(cave);
    image(roomTexture, width/2, height/2);
    
    // room border 
    stroke(30); 
    strokeWeight(7); 
    noFill();
    rect(width/2, height/2, roomWidth, roomHeight);
    initializeGame();
    
  }
  
  void initializeGame() {
    exit.show();

    textSize(24);
    textAlign(CENTER, CENTER);
    fill(255);
    text("EXIT", 60, 95);
    strokeWeight(2);
    
    // if the exit button is pressed
    if (exit.state) {
      pma.state = false;
      gdc.state = false;
      stad.state = false;
      mc.state = false;
      pcl.state = false;
      image(backgroundImage,width/2,height/2);
      levels.increaseLevel();
      resetGame();
      keys = null; // Reset the key
      exit.state = false;
    
    } 

    if (player.health <= 0) {
      gameState = LOST;
      //if (player.score > gameOverScreen.highScore) {
      //  gameOverScreen.highScore = player.score;
      //}
    }
    
    if (gameState == WON || gameState == LOST) {
      endScreen.show();
      noLoop(); 
      return; 
    }
    
    int currentTime = millis();
    int elapsedTime = currentTime - lastSpawnTime;
    
    if (currentTime - lastTime >= interval) {
      difficulty += .5;
      lastTime = millis();
    }


    checkRoomCompleted();
    
    updateEntities();
    
    
      
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
    
    // display text for health bar/stats
    textSize(18);
    textAlign(LEFT); 
    fill(255);
    float percentage_health = (float(player.health) / 50) * 100;
    
    text(nf(percentage_health, 0, 0)+ "%", 22, 36);
    textSize(20);
    text("Score: " + player.score, 20, 60);
    text("Difficulty Multiplier:  x" + difficulty, 510, 36);
  }
  
  void generateRoom() {
    roomWidth = int(random(roomMinWidth, roomMaxWidth));
    roomHeight = int(random(roomMinHeight, roomMaxHeight));
    boxX = roomWidth / 2;
    boxY = roomHeight / 2;
    
  }
  
  
  void checkRoomCompleted() {
    // Check for collision with the key
    if (keys != null && keys.collidesWithPlayer(player)) {
      keyCollected = true;
      //room = null;
      updateTracker();
      pma.state = false;
      gdc.state = false;
      stad.state = false;
      mc.state = false;
      pcl.state = false;
      image(backgroundImage,width/2,height/2);
      levels.increaseLevel();
      resetGame();
      keys = null; // Reset the key
    }
  }
  
  void updateTracker() {
  // Check the label of the button and update the corresponding boolean value
    switch(roomTracker) {
      case 0:
        println("room tracker updated");
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
        // Handle unknown labels or do nothing
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
    
    bullets.removeAll(bulletsToRemove);
    bulletsToRemove.clear();
  }
  
   float getBoxX() {
    return boxX;
  }
  
  float getBoxY() {
    return boxY;
  }
  
}