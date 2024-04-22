class Enemy {
  int health;
  int maxHealth;
  float damageAmt;
  float levelMultiplier;
  PVector position;
  PVector direction;
  float speed;
  float radius;
  color c;

  Enemy(int h, int damage, int diff) {
    health = h;
    maxHealth = h;
    damageAmt = damage;
    levelMultiplier = 3; // Default multiplier

    
    
    float centerX = width/2;
    float centerY = height/2;
    //float boxX = room.roomWidth / 2;
    //float boxY = room.roomHeight / 2;

    boxX = room.getBoxX();
    boxY = room.getBoxY();
    position = new PVector(random(centerX - boxX + 10, centerX + boxX) -10, random(centerY - boxY +10, centerY + boxY - 10));
        
    direction = new PVector(0, 0);
    speed = 0.5;
    radius = 10;
    c = color(random(255), random(255), random(255));
  }

  void update(ArrayList<Enemy> otherEnemies) {
    PVector target = PVector.sub(player.position, position);
    target.normalize();
    target.mult(speed);
    
    PVector avoidCollision = avoidCollisions(otherEnemies);
    avoidCollision.mult(1.2);
    target.add(avoidCollision);

    PVector move = PVector.sub(target, direction);
    direction.add(move);

    position.add(direction);
  }

  void display() {
    fill(c);
    ellipse(position.x, position.y, 20, 20);
    drawHealthBar(); // Call drawHealthBar to display health bar
  }

  void drawHealthBar() {
    float barWidth = map(health, 0, maxHealth, 0, 20);
    float barHeight = 3;
    float xOffset = position.x - barWidth / 2;
    float yOffset = position.y - radius - 10; // Place health bar overhead
    fill(255, 0, 0);
    rect(xOffset, yOffset, barWidth, barHeight);
  }

  PVector avoidCollisions(ArrayList<Enemy> otherEnemies) {
    PVector padding = new PVector(0, 0);

    for (Enemy enemy: otherEnemies) {
      if (enemy != this) {
        float dx = enemy.position.x - position.x;
        float dy = enemy.position.y - position.y;
        float distance = sqrt(dx * dx + dy * dy);
        if (distance < radius * 2.5) {
          PVector amountPadding = PVector.sub(position, enemy.position).div(distance);
          padding.add(amountPadding);
        }
      }
    }
    return padding;
  }
  
  boolean hits(Player player) {
    float d = dist(position.x, position.y, player.position.x, player.position.y);
    return (d < radius + 20); 
  }
  
}
