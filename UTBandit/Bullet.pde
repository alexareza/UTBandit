class Bullet {
  PVector position;
  PVector velocity;
  PImage bulletImage; // Image for the bullet
  ArrayList<Spark> sparks; // List to store spark particles

  Bullet(float x, float y, float angle) {
    position = new PVector(x, y);
    velocity = PVector.fromAngle(angle);
    velocity.mult(10);
    // Load the image for the bullet
    bulletImage = loadImage("bullet.png");
    // Initialize spark particles
    sparks = new ArrayList<Spark>();
    for (int i = 0; i < 5; i++) { // Create 5 spark particles
      sparks.add(new Spark(random(-5, 5), random(-5, 5))); // Provide offset for sparks
    }
  }
  
  void update() {
      position.add(velocity);
      for (Spark spark : sparks) {
          spark.update(position.x, position.y, velocity.x, velocity.y); 
      }
  }
  
  
  void display() {
    // Draw the bullet image at the bullet's position
    imageMode(CENTER);
    image(bulletImage, position.x, position.y, 20, 20);
    // Display spark particles
    for (Spark spark : sparks) {
      spark.display();
    }
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
