class Spark {
  PVector offset;
  float sparkX;
  float sparkY;
  float lifespan;
  
  Spark(float offsetX, float offsetY) {
    offset = new PVector(offsetX, offsetY); 
    lifespan = 255;
  }
  
  void update(float bulletX, float bulletY, float bulletVelocityX, float bulletVelocityY) {
    PVector trailingOffset = new PVector(bulletVelocityX, bulletVelocityY).mult(-5); 
    sparkX = bulletX + offset.x + trailingOffset.x;
    sparkY = bulletY + offset.y + trailingOffset.y;
    lifespan -= 5;
  }
  
  void display() {
    noStroke();
    fill(255, lifespan);
    ellipse(sparkX, sparkY, 3, 3);
  }
}
