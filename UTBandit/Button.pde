class Button extends Clickable {
  float x;
  float y;
  float s;
  float s2;
  String label;
  color fill;
  color stroke;
  color textColor;
  float strokeWeight;
  float textSize;
 
  Button(float x, float y, float s, float s2, String label, color fill, color stroke, color textColor, float strokeWeight, float textSize) {
    this.x = x;
    this.y = y;
    this.s = s;
    this.s2 = s2;
    this.label = label;
    
    this.fill = fill;
    this.stroke = stroke;
    this.textColor = textColor;
    this.strokeWeight = strokeWeight;
    this.textSize = textSize;
  }
  
  Button(float x, float y, float s, float s2, String label) {
    this(x, y, s, s2, label, color(172,88,33), color(172,88,33), color(0), 1, 12);
  }
  
  Button(float x, float y, float s, float s2) {
    this(x, y, s, s2, "", color(172,88,33), color(172,88,33), color(0), 1, 12);
  }
  
  void show() {
    shapeMode(CENTER);
    fill(fill);
    noStroke();
    //stroke(stroke);
    strokeWeight(strokeWeight);
    ellipse(x, y, s, s2);

    textAlign(CENTER, CENTER);
    fill(0);
  }
  
  boolean isMouseInside() {
  float distance = dist(mouseX, mouseY, this.x, this.y);
  // Check if distance is less than or equal to the circle's radius
  
  // check if "exit" button is being pressed specifically
  if (this.label == "exit" && exit != null) {
    if (distance <= this.s/2) {
      println(true);
      return true; // Mouse is inside the circle
    } else {
      return false; // Mouse is outside the circle
    }
  }
  
  // every other button behavior
  else if (room == null) {
    if (distance <= this.s/2) {
      return true; // Mouse is inside the circle
    } else {
      return false; // Mouse is outside the circle
    }
  }
  return false;
}
  
  void callback() {
    //println("Button Pressed");
  }
  
}
