import 'dart:async';

import 'package:flutter/material.dart';

import './pages/landing_page.dart';
import './utils/db_access.dart';
import './utils/question.dart';

Future<void> initialize() async {
  DbAccess dbAccess = new DbAccess();
  await dbAccess.initializeDb();
  await dbAccess.addQuestion(new Question(-1, "Example question 1?", true));
  await dbAccess.addQuestion(new Question(-1, "Example question 2?", false));
}

void main() async {
  await initialize();
  
  runApp(new MaterialApp(
    home: new LandingPage()
  ));
}