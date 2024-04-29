class Levels {
  int currentLevel = 1;
  boolean enemiesSpawned = false; // Flag to track if enemies have been spawned
  
  void levelBehavior() {
    
    switch (currentLevel) {
      case 1:
        levelOneBehavior();
        break;
      case 2:
        levelTwoBehavior();
        break;
      case 3:
        levelThreeBehavior();
        break;
      case 4:
        levelFourBehavior();
        break;
      case 5:
        levelFiveBehavior();
        break;
      default:
        // No behavior for other levels
        break;
    }
  }

  void levelOneBehavior() {
    // Increase difficulty
    difficulty = 1;
    if (!enemiesSpawned) {
      spawnEnemies();
      enemiesSpawned = true;
    }
  }

  void levelTwoBehavior() {
    // Increase difficulty
    difficulty = 1.5;
    if (!enemiesSpawned) {
      spawnEnemies();
      enemiesSpawned = true;
    }
  }

  void levelThreeBehavior() {
    // Increase difficulty
    difficulty = 2;
    if (!enemiesSpawned) {
      spawnEnemies();
      enemiesSpawned = true;
    }
  }

  void levelFourBehavior() {
    // Increase difficulty
    difficulty = 2.5;
    if (!enemiesSpawned) {
      spawnEnemies();
      enemiesSpawned = true;
    }
  }

  void levelFiveBehavior() {
    // Increase difficulty
    difficulty = 3;
    if (!enemiesSpawned) {
      spawnEnemies();
      enemiesSpawned = true;
    }
  }

  void increaseLevel() {
    // only increase level if the level has been defeated
    if (exit.state != true) {
      currentLevel++;
    }
    resetGame(); // Reset the game for the new level
  }

  void resetGame() {
    player = new Player();
    enemies.clear();
    bullets.clear();
    powerups.clear();
    gameState = STARTED;
    keys = null; // Reset the key
    enemiesSpawned = false; // Reset the flag for enemies spawned
    loop();
  }

  void spawnEnemies() {
    int numEnemies = determineNumEnemiesToSpawn();
    if (numEnemies > 0 && enemies.isEmpty()) {
      // Spawn enemies for the current level
      for (int i = 0; i < numEnemies; i++) {
        int levelHealth = determineHealth();
        //println("gen enemy",  room.roomX, room.roomY, room.roomWidth, room.roomHeight);
        enemies.add(new Enemy(levelHealth, 10));
      }
      // Reset the key when spawning new enemies for a new level
      keys = null;
    }

    // Check if all enemies are killed and there's no key present
    if (enemies.isEmpty() && keys == null) {
      // Create a key
      keys = new Keys();
    }
  }

  int determineHealth() {
    switch (currentLevel) {
      case 1:
        return 10;
      case 2:
        return 20;
      case 3:
        return 30;
      case 4:
        return 40;
      case 5:
        return 50;
      default:
        return 0; // Return 0 if no specific number of enemies is determined
    }
  }
  
  int determineNumEnemiesToSpawn() {
    switch (currentLevel) {
      case 1:
        return 20;
      case 2:
        return 40;
      case 3:
        return 60;
      case 4:
        return 80;
      case 5:
        return 100;
      default:
        return 0; // Return 0 if no specific number of enemies is determined
    }
  }
}
