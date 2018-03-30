import 'package:flutter/material.dart';
import './quiz_page.dart';
import './create_question_page.dart';
import './questions_list_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.greenAccent,
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Lets quiz', style: new TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold),),
            new Padding(
              padding: new EdgeInsets.all(20.0),
              child: new RaisedButton(
                color: Colors.redAccent,
                onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new QuizPage())),
                child: new Text('Quiz'),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.all(20.0),
              child: new RaisedButton(
                color: Colors.amberAccent,
                onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new CreateQuestionPage())),
                child: new Text('Add question'),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.all(20.0),
              child: new RaisedButton(
                color: Colors.blueAccent,
                onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new QuestionsListPage())),
                child: new Text('All questions'),
              ),
            )
          ],
        )
    );
  }
}
