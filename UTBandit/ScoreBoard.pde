class ScoreBoard {
  
  void saveScore(int timePlayed) {
    Table scores = loadTable("data/highscores.csv");
    TableRow newRow = scores.addRow();
    newRow.setInt(0, timePlayed);
    saveTable(scores, "data/highscores.csv");
  }
  
  int[] loadScores() {
    Table scores = loadTable("highscores.csv");
    int[] scoreList = new int[scores.getRowCount()];
    for (int i = 0; i < scoreList.length; i++) {
      scoreList[i] = scores.getInt(0, i);
    }
    return scoreList;
  }
  
  String scoreString() {
    int[] scores = sort(loadScores());
    String result = "";
    for (int i = 1; i <= min(scores.length, 3); i++) {
      result += i + ": " + formatScore(scores[i]) + "\n";
    }
    return result;
  }
  
  String formatScore(int score) {
    return str(score / 60) + ":" + str(score % 60);
  }
}
