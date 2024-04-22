class Bullet {
  PVector position;
  PVector velocity;
  PImage bulletImage; // Image for the bullet
  
  Bullet(float x, float y, float angle) {
    position = new PVector(x, y);
    velocity = PVector.fromAngle(angle);
    velocity.mult(10);
    // Load the image for the bullet
    bulletImage = loadImage("bullet.png");
  }
  
  void update() {
    position.add(velocity);
  }
  
  void display() {
    // Draw the bullet image at the bullet's position
    imageMode(CENTER);
    image(bulletImage, position.x, position.y, 20, 20);
  }
  
  boolean hits(Enemy enemy) {
    float d = dist(position.x, position.y, enemy.position.x, enemy.position.y);
    if (d < enemy.radius) {
        return true;
    }
    return false;
  }

  boolean hits(Player player) {
    float d = dist(position.x, position.y, player.position.x, player.position.y);
    return (d < 20); // Assuming player's radius is 20
  }
}
