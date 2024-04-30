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
  PFont font = createFont("arcade2.ttf",50);

 
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
    if (this.label == "Instructions") {
      shapeMode(CENTER);
      fill(5, 95);
      noStroke();
      strokeWeight(strokeWeight);
      rect(x, y, s, s2, 20);

      fill(172,88,33);
      textFont(font);
      textSize(22);
      text("HOW TO PLAY", x, y);

    } else {
      shapeMode(CENTER);
      fill(fill);
      noStroke();
      //stroke(stroke);
      strokeWeight(strokeWeight);
      ellipse(x, y, s, s2);
      textAlign(CENTER, CENTER);  
      if (this.label != "BACK" && this.label != "exit" && this.label != "TOWER" && this.label != "exitGame") {
        textSize(15);
       
        fill(0);
        text(this.label, x, y +25);
      }
    }
  }
  
  boolean isMouseInside() {
    float distance = dist(mouseX, mouseY, this.x, this.y);  
    // check if "exit" button is being pressed specifically
    if (this.label == "exit" && exit != null) {
      if (distance <= this.s/2) {
        return true; // Mouse is inside the circle
      } else {
        return false; // Mouse is outside the circle
      }
  } // instructions
  else if (this.label == "Instructions") {
      //back = new ButtonToggle(width/2, height-140, 150, 70, "BACK");

    return (mouseX >= this.x - 150 && mouseX <= width/2 +150 && mouseY >= this.y - 35 && mouseY <= this.y +35);
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
  }
  
}
