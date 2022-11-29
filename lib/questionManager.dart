import 'dart:core';
import 'dart:math';
import 'package:flutter/services.dart';

class Question
{
   var question = "";
   var answer1 = "";
   var answer2 = "";
   var answer3 = "";
   var answer4 = "";
   var correctAnswer = -1;

   Question.empty() {}
   Question(this.question, this.answer1, this.answer2, this.answer3, this.answer4, this.correctAnswer){}
}

class QuestionManager
{
   var countryQuestions = <Question>[];
   var numRand = Random();

   QuestionManager() {}

  void initialize() {
      print("Init");
      readCountryTextFile();
   }

   void readCountryTextFile() async
   {
     String fichero = await rootBundle.loadString("assets/countryQuestions.txt");
     List<String> listaDeFichero;
     listaDeFichero = fichero.split('\n');
     read(listaDeFichero);
   }

   void read(List<String> data)
   {
     int i = 0;
       var question = "";
       var answer1 = "";
       var answer2 = "";
       var answer3 = "";
       var answer4 = "";
       var correctAnswer = -1;

       do{
         question = data[i];
         i++;
         answer1 = data[i];
         i++;
         answer2 = data[i];
         i++;
         answer3 = data[i];
         i++;
         answer4 = data[i];
         i++;
         correctAnswer = int.parse(data[i]);
         i++;
         addQuestion(Question(question, answer1, answer2, answer3, answer4, correctAnswer));
       }while(i < data.length);
   }

   void addQuestion(Question question)
   {
     countryQuestions.add(question);
   }

   Question getRandomQuestion(){
     var randomNumber = numRand.nextInt(countryQuestions.length);
     return countryQuestions[randomNumber];
   }

}

