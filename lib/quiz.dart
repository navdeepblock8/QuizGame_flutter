import 'questions.dart';

class Quizbrain{
  int questionNum = 0;
  List<Question> qBank = [
    Question("India is a democracy",true),
    Question("British ruled India for 200 years",true),
    Question('There is an underwater postbox in India which is still used',false),
    Question('The wettest inhabited place is in India',true),
    Question('Shampoo was invented in India first',true),
    Question('Rose is national flower of India',false),
    Question('India is world\'s second largest English speaking Country',true),
    Question('India is World\s largest wheat producing country',false),
    Question('Diamond was first mined in India',true),
  ];

  void nextQuestion(){
    if(questionNum<qBank.length-1){
      questionNum++;
    }
  }
  String getQuestiontext(){
    return qBank[questionNum].question;
  }
  bool checkAnswer(){
    return qBank[questionNum].answer;
  }
  bool isFinished(){
    if(questionNum >= qBank.length-1){
      return true;
    }else{
      return false;
    }
  }
  void reset(){
    questionNum =0;
  }
}