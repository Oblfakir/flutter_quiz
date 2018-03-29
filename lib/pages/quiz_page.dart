import 'package:flutter/material.dart';

import '../utils/db_access.dart';
import '../utils/question.dart';
import '../utils/quiz.dart';

import '../ui/question_text.dart';
import '../ui/answer_button.dart';
import '../ui/correct_wrong_overlay.dart';
import 'score_page.dart';

class QuizPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new QuizPageState();
  }
}

class QuizPageState extends State<QuizPage> {
  
  bool isOverlayVisible = false;
  Question currentQuestion;
  Quiz quiz;
  String questionText;
  bool isCorrect;
  int questionNumber;
  
  void getQuestions() async {
    DbAccess dbAccess = new DbAccess();
    List<Question> questions = await dbAccess.getQuestions();
    quiz = new Quiz(questions);
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    isCorrect = currentQuestion.answer;
    questionNumber = quiz.questionNumber;
  }
  
  void hideOverlay() {
    Question question = quiz.nextQuestion;
    
    if (question == null) {
      Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (BuildContext context) => new ScorePage(quiz.length, quiz.score)), 
        (Route route) => route == null
      );
    } 
    else
    {
      currentQuestion = question;
      this.setState((){
        isOverlayVisible = false;
        questionText = currentQuestion.question;
        questionNumber = quiz.questionNumber;
      });
    }
  }
  
  void handleAnswer(bool answer) {
    isCorrect =  currentQuestion.answer == answer;
    quiz.answer(isCorrect);
    
    this.setState((){
      isOverlayVisible = true;
    });
  }
  
  @override
  void initState() {
    super.initState();
    
    getQuestions();
  }
  
  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column( // Main Page
          children: <Widget>[
            new AnswerButton(Colors.greenAccent, 'True', () => handleAnswer(true)),
            currentQuestion != null ? new QuestionText(questionText, questionNumber) : new Container(),
            new AnswerButton(Colors.redAccent, 'False', () => handleAnswer(false)),
          ],
        ),
        isOverlayVisible ? new CorrectWrongOverlay(isCorrect, () => hideOverlay()) : new Container()
      ],
    );
  } 
}
