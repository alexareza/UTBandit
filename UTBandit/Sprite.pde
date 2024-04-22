class Sprite {
  PImage[] frames;
  int numFrames;
  float frameWidth;
  float frameHeight;
  int currentFrame;
  int sizex;
  int sizey;
  
  Sprite(String[] imageNames, int frameWidth, int frameHeight, int sizex, int sizey) {
    this.numFrames = imageNames.length;
    this.frames = new PImage[numFrames];
    this.frameWidth = frameWidth* 0.5;
    this.frameHeight = frameHeight* 0.5;
    this.currentFrame = 0;
    this.sizex = sizex;
    this.sizey = sizey;
    
    for (int i = 0; i < numFrames; i++) {
      this.frames[i] = loadImage(imageNames[i]); // Load each image from the array
    }
  }
  
  void display(float x, float y, int sizex, int sizey) {
    image(frames[currentFrame], x, y, sizex, sizey);
  }
  
  void nextFrame() {
    currentFrame = (currentFrame + 1) % numFrames;
  }
}
