import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/mainMenuScreen',
        routes: {
          '/mainMenuScreen': (context) => MainMenu(),
          '/questionsScreen': (context) => QuestionsScreen()
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

class QuestionsScreen extends StatefulWidget {
  @override
  State<QuestionsScreen> createState() => QuestionsScreenState();
}

class QuestionsScreenState extends State<QuestionsScreen> {
  checkAnswer() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla de preguntas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "¿Cuál es la capital de París?",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),

            Image.asset('assets/triviallogo.png', width: 200, height: 200),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                    "África", 175, 100, () => checkAnswer()),
                TextButton(
                    "Albacete", 175, 100, () => checkAnswer()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                    "Londres", 175, 100, () => checkAnswer()),
                TextButton(
                    "Leganés", 175, 100, () => checkAnswer()),
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
