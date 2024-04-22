class ButtonToggle extends Button {
  boolean state;
  boolean prevState = false;
  ButtonToggle(float x, float y, float s, float s2, String label, color fill, color stroke, color textColor, float strokeWeight, float textSize, boolean state) {
    super(x, y, s, s2, label, fill, stroke, textColor, strokeWeight, textSize);
    this.state = state;
  }
  
  ButtonToggle(float x, float y, float s, float s2, String label, boolean state) {
    this(x, y, s, s2, label, color(172,88,33), color(0), color(0), 1, 12, state);
  }
  
  ButtonToggle(float x, float y, float s, float s2, String label) {
    this(x, y,s,s2, label, color(172,88,33), color(0), color(0), 1, 12, false);
  }
  
  ButtonToggle(float x, float y, float s, float s2) {
    this(x, y, s, s2, "", color(172,88,33), color(0), color(0), 1, 12, false);
  }
  
  void callback() {
    super.callback();
    this.state = !this.state;
  }
}
