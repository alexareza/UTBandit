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
      float roomLeftBound = width / 2 - room.roomWidth / 2;
      float roomRightBound = width / 2 + room.roomWidth / 2;
      float roomTopBound = height / 2 - room.roomHeight / 2;
      float roomBottomBound = height / 2 + room.roomHeight / 2;
  
      // Calculate the next position based on movement
      PVector nextPosition = PVector.add(position, movement);
  
      // Check if the next position is within the bounds of the room
      if (nextPosition.x -20 > roomLeftBound && nextPosition.x +20 < roomRightBound) {
          position.x = nextPosition.x; // Update x position if within horizontal bounds
      } else {
          movement.x = 0;
      }
  
      if (nextPosition.y - 20> roomTopBound && nextPosition.y +20 < roomBottomBound) {
          position.y = nextPosition.y; // Update y position if within vertical bounds
      } else {
          movement.y = 0;
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
