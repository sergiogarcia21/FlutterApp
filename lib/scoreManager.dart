class ScoreManager {
  var score = 0;
  var questionDone = 0;

  int getScore() {
    return score;
  }

  int getQuestion() {
    return questionDone;
  }

  void incrementScore() {
    score++;
  }

  void reset() {
    score = 0;
    questionDone = 0;
  }

  void newQuestion() {
    questionDone++;
  }
}
