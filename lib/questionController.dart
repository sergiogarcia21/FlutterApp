
//hay que introducir la carpeta que contiene las imagenes (meter imágenes)

import 'dart:core';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

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
      a();
   }

   void a() async
   {
     String a = await rootBundle.loadString("assets/countryQuestions.txt");
     List<String> lista;
     lista = a.split('\n');
     read(lista);
   }

   /*void initialize (){
      //context = this.context;
      read("flagQuestions.txt", "flag");
      read("countryQuestions.txt", "country");
   }*/

   void read(List<String> data)
   {
     int i = 0;
       var question = "";
       var answer1 = "";
       var answer2 = "";
       var answer3 = "";
       var answer4 = "";
       var correctAnswer = -1;
       var drawable = "";

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
         drawable = data[i];
         i++;
         print(join(drawable));
         addQuestion(Question(question, answer1, answer2, answer3, answer4, correctAnswer, drawable), 'country');
       }while(i < data.length);
   }

   void reads(String fileName, String type)
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
         print("dj");
         return countryQuestions[randomNumber];
      }
      else
      {
         print("No topic found. Discard question");
         return Question("ERROR", "ERROR", "ERROR", "ERROR", "ERROR", -1, "triviallogo");
      }
   }

}

