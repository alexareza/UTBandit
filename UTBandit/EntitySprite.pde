class EntitySprite {
  int N;
  PImage[][] frames;
  int frameRate;
  
  final static int LEFT = 0;
  final static int RIGHT = 1;
  final static int UP = 2;
  final static int DOWN = 3;
  final static int IDLE = 4;
  final String[] DIRECTIONS = {"left", "right", "up", "down", "idle"};
  
  int facing = IDLE;
  
  EntitySprite(String imageNamePrefix, String imageNamePostfix, int N, int frameRate) {
    this.N = N;
    this.frameRate = frameRate;
    frames = new PImage[5][N];
    for (int i = 0; i < DIRECTIONS.length; i++) {
      for (int j = 0; j < N; j++) {
        String imageName = imageNamePrefix + "-" + DIRECTIONS[i] + "-" + nf(j + 1, 2) + imageNamePostfix;
        PImage frame = loadImage(imageName);
        frame.resize(30, 60);
        frames[i][j] = frame;
      }
    }
  }
  
  void show(float x, float y) {
    imageMode(CENTER);
    image(frames[facing][(frameCount / frameRate) % N], x, y);
  }
}
