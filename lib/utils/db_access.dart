import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import './question.dart';

class DbAccess {
  
  Future<String> _getDbPath() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return '${documentsDirectory.path}/demo.db';
  }
  
  Future<void> initializeDb() async {
    String path = await _getDbPath();
    await deleteDatabase(path);
    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute( "CREATE TABLE Questions (id INTEGER PRIMARY KEY, question TEXT, answer INTEGER)");
        }
    );
  }
  
  Future<List<Question>> getQuestions() async {
    String path = await _getDbPath();
    Database database = await openDatabase(path, version: 1);
    
    List<Map> data = await database.rawQuery('SELECT * FROM Questions');
    List<Question> questions = new List<Question>();
    data.forEach((item) {
      questions.add(new Question(item['id'], item['question'], item['answer'] == 1 ? true : false));
    });
    await database.close();  
    return questions;
  }
  
  Future<void> updateQuestion(int id, Question question) async {
    String path = await _getDbPath();

    Database database = await openDatabase(path, version: 1);
    await database.rawUpdate('UPDATE Questions SET question = ?, answer = ? WHERE id = ?', [question.question, question.answer, id]);
    await database.close();
  }
  
  Future<void> deleteQuestion(Question question) async {
    String path = await _getDbPath();

    Database database = await openDatabase(path, version: 1);
    await database.rawDelete('DELETE FROM Questions WHERE id = ?', [question.id]);
    await database.close();  
  }
  
  Future<void> addQuestion(Question question) async {
    String path = await _getDbPath();

    Database database = await openDatabase(path, version: 1);
    await database.transaction((transaction) async {
      await transaction.rawInsert('INSERT INTO Questions(question, answer) VALUES(?, ?)',[question.question, question.answer]);
    });
    await database.close();  
  }
}