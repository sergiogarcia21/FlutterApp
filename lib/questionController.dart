
//hay que introducir la carpeta que contiene las imagenes (meter imágenes)

import 'dart:core';
import 'dart:math';
import 'dart:io';
import 'package:path/path.dart' as p;

class Question
{
   var question = "";
   var answer1 = "";
   var answer2 = "";
   var answer3 = "";
   var answer4 = "";
   var correctAnswer = -1;
   var drawable = "";

   Question.empty() {}
   Question(this.question, this.answer1, this.answer2, this.answer3, this.answer4, this.correctAnswer, this.drawable){}
}

class QuestionController
{
   var flagQuestions = <Question>[];
   var countryQuestions = <Question>[];
   var context;
   var numRand = Random();

   QuestionController() {}

  void initialize() {
      print("Init");
      var question = "¿Cual es la capital de España?";
      var answer1 = "Barcelona";
      var answer2 = "Madrid";
      var answer3 = "Sevilla";
      var answer4 = "Asturias";
      var correctAnswer = 2;
      var drawable = "SLSAL";
      var uno = Question(question, answer1, answer2, answer3, answer4, correctAnswer, drawable);
      flagQuestions.add(uno);

      question = "¿De que país es esta bandera? ";
      answer1 = "Bélgica";
      answer2 = "Alemania";
      answer3 = "Francia";
      answer4 = "Grecia";
      correctAnswer = 4;
      drawable = "SLSAL";
      var dos = Question(question, answer1, answer2, answer3, answer4, correctAnswer, drawable);
      flagQuestions.add(dos);
   }

   /*void initialize (){
      //context = this.context;
      read("flagQuestions.txt", "flag");
      read("countryQuestions.txt", "country");
   }*/

   void read(String fileName, String type)
   {
      try
      {
         var inputStream = context.assets.open(fileName);
         var bufferedReader = inputStream.bufferedReader();

         var question = "";
         var answer1 = "";
         var answer2 = "";
         var answer3 = "";
         var answer4 = "";
         var correctAnswer = -1;
         var isEndOfFile = false;
         var drawable = "";

         do{
            question = bufferedReader.readAsString();
            answer1 = bufferedReader.readAsString();
            answer2 = bufferedReader.readAsString();
            answer3 = bufferedReader.readAsString();
            answer4 = bufferedReader.readAsString();
            correctAnswer = int.parse(bufferedReader.readAsString());
            drawable = bufferedReader.readAsString();
            addQuestion(Question(question, answer1, answer2, answer3, answer4, correctAnswer, drawable), type);
            isEndOfFile = bufferedReader.ready();
         }while(isEndOfFile);

         bufferedReader.close();
      }
      catch(e)
      {
         print("Error");
      }
   }

   void addQuestion(Question question, String type)
   {
      if (type == "flag")
      {
         flagQuestions.add(question);
      }
      else if(type == "country")
      {
         countryQuestions.add(question);
      }
      else
      {
         print("No topic found. Discard question");
      }
   }

   Question getQuestion(String type){
      if (type == "flag")
      {
         var randomNumber = numRand.nextInt(flagQuestions.length);
         return flagQuestions[randomNumber];
      }
      else if(type == "country")
      {
         var randomNumber = numRand.nextInt(countryQuestions.length);
         return countryQuestions[randomNumber];
      }
      else
      {
         print("No topic found. Discard question");
         return Question("ERROR", "ERROR", "ERROR", "ERROR", "ERROR", -1, "triviallogo");
      }
   }

}

