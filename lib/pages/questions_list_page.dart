import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/db_access.dart';
import '../utils/question.dart';
import 'edit_question_page.dart';

class QuestionsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new QuestionsListPageState();
  }
}

class QuestionsListPageState extends State<QuestionsListPage> {
  List<Widget> _children = new List<Widget>();
  
  Future<List<Widget>> getQuestions() async {
    DbAccess dbAccess = new DbAccess();
    List<Question> questions = await dbAccess.getQuestions();
    List<Widget> children = new List<Widget>();
    children.add(new Padding(padding: new EdgeInsets.symmetric(vertical: 5.0)));
    
    questions.forEach((Question question){
      children.add(new ListTile(
        title: new Text(
          question.question,
          style: new TextStyle(fontSize: 16.0),
        ),
        trailing: new Row(
          children: <Widget>[
            new IconButton(
              icon: new Icon(Icons.edit, size: 30.0),
              onPressed: () async {
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new EditQuestionPage(question)));
              },
            ),
            new IconButton(
              icon: new Icon(Icons.delete, size: 30.0),
              onPressed: () async {
                await dbAccess.deleteQuestion(question);
                refreshQuestions();
              },
            )
          ],
        ),
      ));
      children.add(new Divider());
    });
    return children;
  }
  
  @override
  void initState() {
    super.initState();
    refreshQuestions();
  }
  
  void refreshQuestions() {
    getQuestions().then((List<Widget> children) {
      this.setState(() {
        _children = children;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Questions"),
      ),
      body: new Material(
        color: Colors.blueAccent,
        child: new ListView(
          children: _children,
        ),
      ),
    );
  }
  
}