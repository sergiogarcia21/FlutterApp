import 'package:flutter/material.dart';
import 'package:flutterapp/questionController.dart';
import 'dart:core';
import 'dart:math';
import 'dart:io';
import 'package:path/path.dart' as p;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  QuestionController qc = QuestionController();


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
          '/questionsScreen': (context) => QuestionsScreen(qc),
          '/endGameScreen': (context) => EndGameScreen()
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/triviallogo.png'),
            //MainMenuButton(Icons.play_arrow_rounded),
            //const MainMenuButton(Icons.exit_to_app_rounded),
            Text(
              '2',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MainMenu extends StatelessWidget {
  play(BuildContext context) {
    Navigator.pushNamed(context, '/questionsScreen');
    final _questionController = QuestionController();
    //_questionController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Principal'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('End Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/triviallogo.png', width: 250, height: 250),
            MainMenuButton(
                Icons.exit_to_app_rounded, () => debugPrint("saidfhjauidfh")),
          ],
        ),
      ),
    );
  }
}

class QuestionsScreen extends StatefulWidget {
  QuestionsScreen(this.questionController);
  final QuestionController questionController;
  Question preguntaActual = Question.empty();

  void initializeQuestion(){
    this.preguntaActual = questionController.getQuestion("flag");
  }

  @override
  State<QuestionsScreen> createState() => QuestionsScreenState();
}

class QuestionsScreenState extends State<QuestionsScreen> {

  void checkAnswer(correct_answer, click_answer){
    if (correct_answer == click_answer){
      print("ACIERTO");
    }
    else{
      print("FALLO");
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.initializeQuestion();
    return Scaffold(
      appBar: AppBar(
        title: Text('Preguntas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              widget.preguntaActual.question,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),

            Image.asset('assets/triviallogo.png', width: 200, height: 200),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                    widget.preguntaActual.answer1, 175, 100, () => checkAnswer(widget.preguntaActual.correctAnswer, 1)),
                TextButton(
                    widget.preguntaActual.answer2, 175, 100, () => checkAnswer(widget.preguntaActual.correctAnswer, 2)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                    widget.preguntaActual.answer3, 175, 100, () => checkAnswer(widget.preguntaActual.correctAnswer, 3)),
                TextButton(
                    widget.preguntaActual.answer4, 175, 100, () => checkAnswer(widget.preguntaActual.correctAnswer, 4)),
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
  const TextButton(this.text, this.width, this.height, this.onPressedButton, {super.key});
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

class ScoreController{
  var score = 0;
  var questionDone = 0;

  int getScore(){
    return score;
  }

  int getQuestion(){
    return questionDone;
  }

  void incrementScore(){
    score++;
  }

  void reset(){
    score = 0;
    questionDone = 0;
  }

  void newQuestion(){
    questionDone++;
  }
}






