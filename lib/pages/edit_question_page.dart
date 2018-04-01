import 'package:flutter/material.dart';
import '../utils/db_access.dart';
import '../utils/question.dart';
import 'questions_list_page.dart';

class EditQuestionPage extends StatefulWidget {
  
  final Question question;
  
  EditQuestionPage(this.question);

  @override
  State<StatefulWidget> createState() {
    return new EditQuestionState();
  }
}

class EditQuestionState extends State<EditQuestionPage> with SingleTickerProviderStateMixin{
  Animation<double> _textAnimation;
  AnimationController _textAnimationController;
  TextEditingController textEditingController;
  String questionText;
  bool answer;
  
  @override
  void initState() {
    super.initState();
    questionText = widget.question.question;
    answer = widget.question.answer;
    textEditingController = new TextEditingController(
      text: questionText
    );
    
    _textAnimationController = new AnimationController(
      duration: new Duration(milliseconds: 500),
      vsync: this
    );
    _textAnimation = new CurvedAnimation(parent: _textAnimationController, curve: Curves.easeOut);
    _textAnimation.addListener(() => this.setState((){}));
    _textAnimationController.forward();
  }
  
  @override
  void dispose() {
    _textAnimationController.dispose();
    super.dispose();
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
    await dbAccess.updateQuestion(widget.question.id, new Question(-1, questionText, answer));
    Navigator.of(context).pop(context);
    Navigator.of(context).pop(context);
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (BuildContext context) => new QuestionsListPage())
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add question")
      ),
      body: new Material(
        color: Colors.amberAccent,
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text("Enter question:", style: new TextStyle(fontSize: 5.0 + _textAnimation.value * 16.0),),
                  new Padding(
                    padding: new EdgeInsets.symmetric(vertical: 20.0, horizontal: 200.0 - 180.0 * _textAnimation.value),
                    child: new TextField(
                      controller: textEditingController,
                      decoration: new InputDecoration(
                        hintText: 'Your question'
                      ),
                      onChanged: (String str) => handleInput(str),
                    )
                  ),
                  new Text("Question answer:", style: new TextStyle(fontSize: 5.0 + _textAnimation.value * 16.0),),
                  new Checkbox(value: answer, onChanged: (bool state) => handleCheckbox(state),),
                  new Padding(
                    padding: new EdgeInsets.only(top: 40.0),
                    child: new RaisedButton(
                      color: Colors.greenAccent,
                      child: new Text("Edit question", style: new TextStyle(fontSize: 20.0),),
                      onPressed: () => onSubmit()
                    )
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }
  
}