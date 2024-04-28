class EndScreen {
  
   PImage bg = loadImage("roomfloor.jpeg");
 
  EndScreen() {
    
    //imageMode(CENTER);
    textAlign(CENTER);
    bg.resize(200,200);
  }
   void show() {
    textAlign(CENTER);
    tileSize = 200;
    float xPos = 0;
    float yPos = 0;
    // Calculate number of tiles needed in each direction
    int numHorizontalTiles = width / tileSize;
    int numVerticalTiles = height / tileSize;
    for (int y = 0; y < numVerticalTiles +1; y++) {
      for (int x = 0; x < numHorizontalTiles +1; x++) {
        // Calculate position of the current tile
        xPos = (x * tileSize);
        yPos = (y * tileSize);
        image(bg, xPos, yPos, tileSize, tileSize);
      }
    }
    fill(255);
    textSize(50);
  }
  void show_scoreBoard(ScoreBoard scoreBoard) {
    textAlign(CENTER);
    textSize(25);
    text("SCOREBOARD", width / 2, height - 200);
    textSize(20);
    text(scoreBoard.scoreString(), width / 2, height - 130);
  }
  
  void show_play_again_button() {
    textAlign(CENTER);
    //rectMode(CENTER);
    fill(172,88,33);
    rect(width/2, height/2 + 100, 200, 50, 10);
    fill(255);
    textSize(18);
    text("PLAY AGAIN", width/2, height/2 + 110);
  }
  
  void show_score_this_run(int secondsPlayed) {
    textSize(20);
    text("Time: " + secondsPlayed/1000 + " seconds", width/2, height/3 + 20);
  }

  void show_loss() {
    textAlign(CENTER);
    show();
    text("YOU LOST", width / 2, height / 4);
    text("GAME OVER", width / 2, height / 2);
    show_play_again_button();
  }
  
  void show_win(int secondsPlayed) {
    textAlign(CENTER);
    show();
    text("YOU WON!", width / 2, height / 4);
    show_score_this_run(secondsPlayed);
    show_play_again_button();
  }
}
