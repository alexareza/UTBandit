class Player {
  PVector position;
  PVector look;
  int health = 50;
  int score = 0;
  private PVector movement = new PVector(0, 0);
  private boolean debug = false;
  
  EntitySprite sprite;
  
  Player() {
    this.position = new PVector(width / 6, height / 2);
    this.look = new PVector(1, 1).div(sqrt(2));
    sprite = new EntitySprite("player", ".png", 4, 5);
  }
  
  void show() {
    ellipseMode(CENTER);
    fill(255);
    stroke(0);
    //ellipse(this.position.x, this.position.y, 40, 40);
    sprite.show(this.position.x, this.position.y);
    
    if (debug) {
      debug_info();
    }
  }
  
  void shoot() {
    float angle = atan2(look.y, look.x);
    for (int i = 0; i < bulletCount; i++) {
      float bulletAngle = angle + random(-PI/8, PI/8);
      bullets.add(new Bullet(position.x, position.y, bulletAngle));
    }
  }
  
  void debug_info() {
    textAlign(CENTER, BOTTOM);
    stroke(0);
    fill(0);
    text(debug_string(), this.position.x, this.position.y - 100);
  }
  
  String debug_string() {
    String result = "Position: " + this.position.x + ", " + this.position.y;
    result += "\nLook: " + this.look.x + ", " + this.look.y;
    return result;
  }
  
  void update_position() {
    this.position.add(this.movement.mult(1));
    if (this.movement.mag() == 0) {
      this.sprite.facing = this.sprite.IDLE;
    }
    update_look();
  }
  
  void update_look() {
    PVector lookVector = new PVector(mouseX, mouseY).sub(this.position);
    this.look = lookVector.div(lookVector.mag());
  }
  
  void onKeyPressed() {
    switch (key) {
      case 'w':
        this.movement.y = -1.5;
        this.sprite.facing = this.sprite.UP;
        break;
      case 'a':
        this.movement.x = -1.5;
        this.sprite.facing = this.sprite.LEFT;
        break;
      case 's':
        this.movement.y = 1.5;
        this.sprite.facing = this.sprite.DOWN;
        break;
      case 'd':
        this.movement.x = 1.5;
        this.sprite.facing = this.sprite.RIGHT;
        break;
    }
  }
  
  void onKeyReleased() {
    switch (key) {
      case 'w':
        this.movement.y = 0;
        break;
      case 'a':
        this.movement.x = 0;
        break;
      case 's':
        this.movement.y = 0;
        break;
      case 'd':
        this.movement.x = 0;
        break;
    }
  }
  
  void onMouseMoved() {
    update_look();
  }
  
  void onMousePressed() {
    switch (mouseButton) {
      case LEFT:
        shoot();
    }
  }

  void increaseBulletCount() {
    bulletCount++;
  }
}
