class Keys {
  PVector position;
  float radius;
  PImage sprite;
  Sprite keySprite; // Declare keySprite variable in the Keys class

  Keys() {
    float centerX = width/2;
    float centerY = height/2;
    position = new PVector(random(centerX - boxX + 10, centerX + boxX) -10, random(centerY - boxY +10, centerY + boxY - 10));
    radius = 3;
    initializeSprite(); // Initialize the sprite when creating a new Keys object
    keySound.play();
  }

  void initializeSprite() {
    int numFrames = 23;
    String[] keyImageNames = new String[numFrames];
    for (int i = 0; i < numFrames; i++) {
      keyImageNames[i] = "key-" + i + ".png";
    }
    keySprite = new Sprite(keyImageNames, 20, 20, 80, 80); // Assuming each frame has a size of 100x100 pixels
  }

  void display() {
    keySprite.display(position.x, position.y, 80, 80);
  }

  boolean collidesWithPlayer(Player player) {
    float d = dist(position.x, position.y, player.position.x, player.position.y);
    return (d < radius + 20); // Assuming player's radius is 20
  }
}
