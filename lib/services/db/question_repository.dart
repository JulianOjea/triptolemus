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
      version: 1,
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
}

// Future<Database> initQuestionDB() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     return openDatabase(
//       join(await getDatabasesPath(), 'question_database.db'),
//       onCreate: (db, version) {
//         return db
//             .execute('CREATE TABLE questions(text_column text, category text)');
//       },
//       version: 1,
//     );
//   }

// Future<List<Question>> getQuestionsListOnDB() async {
//     final db = await initQuestionDB();

//     final List<Map<String, Object?>> questionMaps = await db
//         .query('questions', columns: ["rowid", "text_column", "category"]);

//     return [
//       for (final {
//             'text_column': text as String,
//             'category': category as String,
//             'rowid': rowid as int,
//           } in questionMaps)
//         Question(text, category, isCustom: true, questionId: rowid),
//     ];
//   }

//   Future<void> updateQuestion(Question question) async {
//     final db = await initQuestionDB();

//     await db.update(
//       'questions',
//       question.toMap(),
//       where: 'rowid = ?',
//       whereArgs: [question.questionId],
//     );
//   }

//   Future<void> deleteQuestion(int id) async {
//     final db = await initQuestionDB();

//     await db.delete(
//       'questions',
//       where: 'rowid = ?',
//       whereArgs: [id],
//     );
//   }

// Future setActiveQuestionsList() async {
//     if (customQuestionList.isEmpty) {
//       var qlist = await getQuestionsListOnDB();
//       customQuestionList.addAll(qlist);
//     }

//     activeQuestions.clear();
//     if (categories[3].isActive) {
//       // TODO CHANGE THIS LOGIC
//       activeQuestions.addAll(customQuestionList);
//     } else {
//       categories.where((qc) => qc.isActive).forEach((element) {
//         activeQuestions.addAll(getQuestionsByCategory(element));
//         // if (insertQustomCuestion.value) {
//         //   var matchlist = customQuestionList
//         //       .where((customQ) => customQ.category == element.value)
//         //       .toList();

//         //   activeQuestions.addAll(matchlist);
//         // }
//       });
//     }

//     activeQuestions.refresh();
//   }
