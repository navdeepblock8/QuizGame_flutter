import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz.dart';
Quizbrain qz = Quizbrain();
void main() {
  runApp(Quiz());
}

class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: QuizPage()),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scorekeeper =[];
  int correct = 0;
  void resetScorekeeper(){
    scorekeeper = [];
    correct = 0;
  }
  void addWrong(){
    scorekeeper.add(Icon(
      Icons.close,
      color: Colors.red,
    ));
  }
  void addRight(){
    scorekeeper.add(Icon(
      Icons.check,
      color: Colors.green,
    ));
    correct++;
  }
  Future showAlert(int correct) async {
    return Future.delayed(Duration(milliseconds: 100), () {
      Alert(
          context: context,
          title: 'Your score $correct out of 9'
      ).show();
    });
  }
  void resetGame(int correct) async {
    await showAlert(correct);
    setState(() {
      qz.reset();
      resetScorekeeper();
    });
  }


  void checkAnswer(bool pickedAnswer){
    setState(() {
      if(qz.isFinished()==true) {
        if (pickedAnswer == qz.checkAnswer()) {
          addRight();
        }
        else {
          addWrong();
        }
        resetGame(correct);

      }

      else {
        if (pickedAnswer == qz.checkAnswer()) {
          addRight();
        }
        else {
          addWrong();
        }
        qz.nextQuestion();
      }});

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),

            child: Center(
              child: Text(
                'Do You India Enough?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
                child: Text(
                  qz.getQuestiontext(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                )
            ),
          ),
        ),

        Expanded(

          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: FlatButton(
              color: Colors.green,
              onPressed: (){
                checkAnswer(true);
              },
              child: Text(
                'True',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: FlatButton(
              color: Colors.red,
              onPressed: (){
                checkAnswer(false);
              },
              child: Text(
                'False',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        )
      ],
    );
  }
}


