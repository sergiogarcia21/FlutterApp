import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/questionManager.dart';
import 'package:flutterapp/scoreManager.dart';
import 'dart:core';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final QuestionManager qc = QuestionManager();
  final ScoreManager sc = ScoreManager();
  final AudioCache ap = AudioCache();

  @override
  Widget build(BuildContext context) {
    qc.initialize();
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/mainMenuScreen',
        routes: {
          '/mainMenuScreen': (context) => MainMenu(ap),
          '/questionsScreen': (context) => QuestionsScreen(qc, sc, ap),
          '/endGameScreen': (context) => EndGameScreen(sc, ap)
        });
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu(this.audioPlayer);
  final AudioCache audioPlayer;

  play(BuildContext context) {
    Navigator.pushNamed(context, '/questionsScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Principal'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Text(
              "Countrily",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 50),
            ),
            Image.asset('assets/triviallogo.png', width: 250, height: 250),
            MainMenuButton(Icons.play_arrow_rounded, () {
              play(context);
              audioPlayer.play('buttonClick.mp3');
            }),
          ],
        ),
      ),
    );
  }
}

class EndGameScreen extends StatelessWidget {
  const EndGameScreen(this.scoreController, this.audioPlayer);
  final ScoreManager scoreController;
  final AudioCache audioPlayer;

  String getPictureID() {
    String id = "";

    if (scoreController.getScore() < (scoreController.getQuestion() / 6)) {
      id = 'assets/trivial0de6.png';
    } else if (scoreController.getScore() <
        2 * (scoreController.getQuestion() / 6)) {
      id = 'assets/trivial1de6.png';
    } else if (scoreController.getScore() <
        3 * (scoreController.getQuestion() / 6)) {
      id = 'assets/trivial2de6.png';
    } else if (scoreController.getScore() <
        4 * (scoreController.getQuestion() / 6)) {
      id = 'assets/trivial3de6.png';
    } else if (scoreController.getScore() <
        5 * (scoreController.getQuestion() / 6)) {
      id = 'assets/trivial4de6.png';
    } else if (scoreController.getScore() < scoreController.getQuestion()) {
      id = 'assets/trivial5de6.png';
    } else {
      id = 'assets/trivial2.png';
    }

    return id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('End Game'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Fin de la partida",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              "Puntuación: " +
                  scoreController.getScore().toString() +
                  "/" +
                  scoreController.getQuestion().toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
            Image.asset(getPictureID(), width: 250, height: 250),
            MainMenuButton(Icons.exit_to_app_rounded, () {
              audioPlayer.play('buttonClick.mp3');
              scoreController.reset();
              Navigator.pushNamed(context, '/mainMenuScreen');
            }),
          ],
        ),
      ),
    );
  }
}

class QuestionsScreen extends StatefulWidget {
  QuestionsScreen(
      this.questionController, this.scoreController, this.audioPlayer);
  final QuestionManager questionController;
  final ScoreManager scoreController;
  final AudioCache audioPlayer;

  @override
  State<QuestionsScreen> createState() => QuestionsScreenState();
}

class QuestionsScreenState extends State<QuestionsScreen> {
  Question preguntaActual = Question.empty();
  int numberOfQuizQuestions = 6;

  void checkAnswer(correct_answer, click_answer) {
    if (correct_answer == click_answer) {
      widget.scoreController.incrementScore();
      print("ACIERTO");
      widget.audioPlayer.play('correctSound.mp3');
    } else {
      widget.audioPlayer.play('wrongSound.mp3');
      Vibration.vibrate(duration: 200);
      print("FALLO");
    }

    widget.scoreController.newQuestion();

    if (numberOfQuizQuestions == widget.scoreController.getQuestion()) {
      Navigator.pushNamed(context, '/endGameScreen');
    } else {
      setState(() {
        preguntaActual = widget.questionController.getRandomQuestion();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    preguntaActual = widget.questionController.getRandomQuestion();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              widget.audioPlayer.play('buttonClick.mp3');
              Navigator.pushNamed(context, '/mainMenuScreen');
              widget.scoreController.reset();
            }),
        title: Text('Preguntas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              preguntaActual.question,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
            Image.asset('assets/triviallogo.png', width: 200, height: 200),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(preguntaActual.answer1, 175, 100,
                      () => checkAnswer(preguntaActual.correctAnswer, 1)),
                  TextButton(preguntaActual.answer2, 175, 100,
                      () => checkAnswer(preguntaActual.correctAnswer, 2)),
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(preguntaActual.answer3, 175, 100,
                      () => checkAnswer(preguntaActual.correctAnswer, 3)),
                  TextButton(preguntaActual.answer4, 175, 100,
                      () => checkAnswer(preguntaActual.correctAnswer, 4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainMenuButton extends StatelessWidget {
  const MainMenuButton(this.icon, this.onPressedButton, {super.key});
  final IconData icon;
  final Function onPressedButton;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.black,
        shadowColor: Colors.black,
        elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        minimumSize: Size(200, 100),
      ),
      onPressed: () {
        onPressedButton();
      },
      child: Icon(icon,
          size: 100.0,
          shadows: <Shadow>[Shadow(color: Colors.black, blurRadius: 5.0)]),
    );
  }
}

class TextButton extends StatelessWidget {
  const TextButton(this.text, this.width, this.height, this.onPressedButton,
      {super.key});
  final String text;
  final double width;
  final double height;
  final Function onPressedButton;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.black,
        shadowColor: Colors.black,
        elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        minimumSize: Size(width, height),
      ),
      onPressed: () {
        onPressedButton();
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
