import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:triptolemus/constants/query.dart';
import 'package:triptolemus/models/question.dart';

class QuestionRepository {
  static Future<Database> _openDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), Query.questionDB),
    );
  }

  static Future<Database> initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), Query.questionDB),
      onCreate: (db, version) {
        print("creating Question db");
        return db.execute(Query.createQuestionTable);
      },
      version: 2,
    );
  }

  static Future<void> insertQuestionOnDB(Question question) async {
    Database db = await _openDB();
    await db.insert(Query.questionTable, question.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> insertQuestionListOnDB(
      List<Question> questionList) async {
    Database db = await _openDB();
    print("Inserting question List on db");
    for (var question in questionList) {
      await db.insert(Query.questionTable, question.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  static Future<int> getQuestionCount() async {
    Database db = await _openDB();
    var result = await db.rawQuery(Query.countQuestionsQuery);
    return Sqflite.firstIntValue(result) ?? 0;
  }

  static Future<List<Question>> getQuestionList() async {
    Database db = await _openDB();
    final List<Map<String, Object?>> questionMaps =
        await db.query(Query.questionTable);
    return [
      for (final map in questionMaps) Question.fromMap(map),
    ];
  }

  static Future<void> clearDatabase() async {
    Database db = await _openDB();
    await db.delete(Query.questionTable);
    String path = join(await getDatabasesPath(), Query.questionDB);
    await deleteDatabase(path);
    print("Base de datos eliminada");
  }
}
