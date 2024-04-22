class EndScreen {
  
  void show() {
    background(255);
    
    fill(0);
    textSize(50);
    textAlign(CENTER, TOP);
  }
  
  void show_scoreBoard(ScoreBoard scoreBoard) {
    textAlign(CENTER, BOTTOM);
    fill(0);
    text("Scoreboard", width / 2, height - 200);
    text(scoreBoard.scoreString(), width / 2, height - 100);
  }
  
  void show_play_again_button() {
    rectMode(CENTER);
    fill(100);
    rect(width/2, height/2 + 100, 150, 50, 10);
    fill(255);
    textSize(20);
    text("Play Again", width/2, height/2 + 95);
  }
  
  void show_score_this_run(int secondsPlayed) {
    textSize(20);
    text("Time: " + secondsPlayed + " seconds", width/2, height/2 + 30);
  }

  void show_loss() {
    show();
    text("Game Over", width / 2, height / 2);
    show_play_again_button();
  }
  
  void show_win(int secondsPlayed) {
    show();
    text("You Won!", width / 2, height / 4);
    show_score_this_run(secondsPlayed);
    show_play_again_button();
  }
}
