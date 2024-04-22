class ScoreBoard {
  
  void saveScore(int timePlayed) {
    
    Table scores = loadTable("data/highscores.csv", "header");
    TableRow newRow = scores.addRow();
    newRow.setInt(0, timePlayed);
    saveTable(scores, "data/highscores.csv");
  }
  
  int[] loadScores() {
    Table scores = loadTable("highscores.csv", "header");
    int[] scoreList = new int[scores.getRowCount()];
    for (int i = 0; i < scoreList.length; i++) {
      scoreList[i] = scores.getInt(i, 0);
    }
    return scoreList;
  }
  
  String scoreString() {
    int[] scores = sort(loadScores());
    String result = "";
    for (int i = 0; i < min(scores.length, 3); i++) {
      result += i +1 + ": " + formatScore(scores[i]/100) + "\n";
    }
    return result;
  }
  
  String formatScore(int score) {
    return str(score / 60) + ":" + str(score % 60);
  }
}
