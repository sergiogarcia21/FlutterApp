import 'package:flutter/material.dart';
import 'package:flutterapp/questionController.dart';
import 'package:flutterapp/scoreController.dart';
import 'dart:core';
import 'dart:math';
import 'dart:io';
import 'package:path/path.dart' as p;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final QuestionController qc = QuestionController();
  final ScoreController sc = ScoreController();

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
          '/mainMenuScreen': (context) => MainMenu(),
          '/questionsScreen': (context) => QuestionsScreen(qc, sc),
          '/endGameScreen': (context) => EndGameScreen(sc)
        });
  }
}

class MainMenu extends StatelessWidget {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/triviallogo.png', width: 250, height: 250),
            MainMenuButton(Icons.play_arrow_rounded, () => play(context)),
            MainMenuButton(
                Icons.exit_to_app_rounded, () => debugPrint("saidfhjauidfh")),
          ],
        ),
      ),
    );
  }
}

class EndGameScreen extends StatelessWidget {
  const EndGameScreen(this.scoreController);
  final ScoreController scoreController;

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
            MainMenuButton(
                Icons.exit_to_app_rounded,
                () => {
                      scoreController.reset(),
                      Navigator.pushNamed(context, '/mainMenuScreen')
                    }),
          ],
        ),
      ),
    );
  }
}

class QuestionsScreen extends StatefulWidget {
  QuestionsScreen(this.questionController, this.scoreController);
  final QuestionController questionController;
  final ScoreController scoreController;

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
    } else {
      print("FALLO");
    }

    widget.scoreController.newQuestion();

    if (numberOfQuizQuestions == widget.scoreController.getQuestion()) {
      Navigator.pushNamed(context, '/endGameScreen');
    } else {
      setState(() {
        preguntaActual = widget.questionController.getQuestion("flag");


        print(widget.scoreController.getQuestion());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    preguntaActual = widget.questionController.getQuestion("flag");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(preguntaActual.answer1, 175, 100,
                    () => checkAnswer(preguntaActual.correctAnswer, 1)),
                TextButton(preguntaActual.answer2, 175, 100,
                    () => checkAnswer(preguntaActual.correctAnswer, 2)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(preguntaActual.answer3, 175, 100,
                    () => checkAnswer(preguntaActual.correctAnswer, 3)),
                TextButton(preguntaActual.answer4, 175, 100,
                    () => checkAnswer(preguntaActual.correctAnswer, 4)),
              ],
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
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
