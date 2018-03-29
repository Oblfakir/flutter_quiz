import 'package:flutter/material.dart';

import './pages/landing_page.dart';
import './utils/db_access.dart';
import './utils/question.dart';

void initialize() async {
  DbAccess dbAccess = new DbAccess();
  await dbAccess.initializeDb();
  await dbAccess.addQuestion(new Question("Example question 1?", true));
  await dbAccess.addQuestion(new Question("Example question 2?", false));
}

void main() {
  initialize();
  
  runApp(new MaterialApp(
    home: new LandingPage()
  ));
}