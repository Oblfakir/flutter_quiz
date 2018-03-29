import 'package:flutter/material.dart';
import '../utils/db_access.dart';
import '../utils/question.dart';
import './landing_page.dart';

class CreateQuestionPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new CreateQuestionState();
  }
}

class CreateQuestionState extends State<CreateQuestionPage> {
  TextEditingController textEditingController;
  String questionText;
  bool answer;
  
  @override
  void initState() {
    super.initState();
    questionText = '';
    answer = false;
    textEditingController = new TextEditingController();
  }
  
  void handleInput(String text) {
    this.setState(() {
      questionText = text;
    });
  }
  
  void handleCheckbox(bool state) {
    this.setState(() {
      answer = state;
    });
  }
  
  void onSubmit() async {
    DbAccess dbAccess = new DbAccess();
    await dbAccess.addQuestion(new Question(questionText, answer));
    returnToLanding();
  }
  
  void returnToLanding() {
    Navigator.of(context).pushAndRemoveUntil(
      new MaterialPageRoute(builder: (BuildContext context) => new LandingPage()), 
      (Route route) => route == null
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.amberAccent,
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.all(20.0),
                    child: new TextField(
                      controller: textEditingController,
                      decoration: new InputDecoration(
                        hintText: 'Your question'
                      ),
                      onChanged: (String str) => handleInput(str),
                    )
                  ),
                  new Checkbox(value: answer, onChanged: (bool state) => handleCheckbox(state),)
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.arrow_back, size: 50.0, color: Colors.blueGrey,),
                    onPressed: () => returnToLanding(),
                  ),
                  new Padding(
                    padding: new EdgeInsets.symmetric(horizontal: 50.0),
                  ),
                  new IconButton(
                    icon: new Icon(Icons.done, size: 50.0, color: Colors.green,),
                    onPressed: () => onSubmit(),
                  )
                ],
              ),
            ),
          ],
        )
    );
  }
  
}