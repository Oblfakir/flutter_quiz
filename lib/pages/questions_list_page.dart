import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/db_access.dart';
import '../utils/question.dart';

class QuestionsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new QuestionsListPageState();
  }
}

class QuestionsListPageState extends State<QuestionsListPage> {
  List<Widget> _children = new List<Widget>();
  
  Future<void> getQuestions() async {
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
        trailing: new IconButton(
          icon: new Icon(Icons.delete, size: 50.0),
          onPressed: () async {
            dbAccess.deleteQuestion(question);
            await getQuestions();
          },
        ),
      ));
      children.add(new Divider());
    });
    
    this.setState(() {
      _children = children;
    });
  }
  
  @override
  void initState() {
    super.initState();
    
    getQuestions();
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