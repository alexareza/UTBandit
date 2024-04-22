abstract class Clickable {

  abstract void show();
  abstract boolean isMouseInside();
  abstract void callback();
  
  void onMousePress() {
    if (isMouseInside()) {
      callback();
    } 
  }
}
