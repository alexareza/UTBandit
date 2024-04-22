class Powerup {
  PVector position;
  float radius;
  color c;
  Sprite powerupSprite; // Declare powerupSprite variable in the Powerup class

  Powerup(float x, float y) {
    position = new PVector(x, y);
    radius = 10;
    c = color(0, 255, 0);
    initializeSprite(); // Initialize the sprite when creating a new Powerup object
  }

  void initializeSprite() {
    int numFrames = 4;
    String[] powerupImageNames = new String[numFrames];
    for (int i = 0; i < numFrames; i++) {
      powerupImageNames[i] = "powerup-" + i + ".png";
    }
    powerupSprite = new Sprite(powerupImageNames, 20, 20, 40, 40); // Assuming each frame has a size of 100x100 pixels
  }

  void display() {
    powerupSprite.display(position.x, position.y, 40, 40);
    
  }

  boolean collidesWithPlayer(Player player) {
    float d = dist(position.x, position.y, player.position.x, player.position.y);
    return (d < radius + 20); // Assuming player's radius is 20
  }
}
