import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:triptolemus/data/questions.dart';
import 'package:triptolemus/models/category.dart';
import 'package:triptolemus/models/question.dart';

class QuestionController extends GetxController {
  var categories = [
    QuestionCategory(QuestionCategory.dilemas, true),
    QuestionCategory(QuestionCategory.picante, false),
    QuestionCategory(QuestionCategory.confidenciales, false),
    QuestionCategory(QuestionCategory.personalizadas, false)
  ].obs;

  //List of questions
  var activeQuestions = [].obs;

  //List of custom questions
  var customQuestionList = [].obs;

  // custom question switch state
  var insertQustomCuestion = false.obs;

  set database(Future<Database> database) {}

  String getQuestionString(String name) {
    final random = Random();
    Question question = activeQuestions[random.nextInt(activeQuestions.length)];
    return question.text.replaceAll("%name%", name).replaceAll('😏', name);
  }

  void setActiveQuestionsList() {
    activeQuestions.clear();
    if (categories[3].isActive) {
      activeQuestions.addAll(customQuestionList);
    } else {
      categories.where((qc) => qc.isActive).forEach((element) {
        activeQuestions.addAll(getQuestionsByCategory(element));
        if (insertQustomCuestion.value) {
          var matchlist = customQuestionList
              .where((customQ) => customQ.category == element.value)
              .toList();

          activeQuestions.addAll(matchlist);
        }
      });
    }

    activeQuestions.refresh();
  }

  List<Question> getQuestionsByCategory(QuestionCategory qc) {
    return Questions.questionList
        .where((element) => element.category == qc.value)
        .toList();
  }

  void addActiveCategory(QuestionCategory category) {
    categories.add(category);
  }

  QuestionCategory getCategoryByName(String cat) {
    return categories.firstWhere((qcat) => qcat.value == cat);
  }

  void swichActive(QuestionCategory cat) {
    QuestionCategory qc = getCategoryByName(cat.value);
    qc.isActive = !qc.isActive;

    if (cat.value == QuestionCategory.personalizadas) {
      categories[0].isActive = false;
      categories[1].isActive = false;
      categories[2].isActive = false;
      insertQustomCuestion.value = true;
    } else {
      categories[3].isActive = false;
    }
    categories.refresh();
  }

  void addCustomQuestion(String questionText, String qc) {
    customQuestionList.add(Question(questionText, qc, isCustom: true));
  }

  bool isAnyCatSelected() {
    return categories[0].isActive ||
        categories[1].isActive ||
        categories[2].isActive ||
        categories[3].isActive;
  }

  Future<Database> initQuestionDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), 'question_database.db'),
      onCreate: (db, version) {
        return db
            .execute('CREATE TABLE questions(text_column text, category text)');
      },
      version: 1,
    );
  }

  Future<void> insertQuestionOnDB(Question question) async {
    final db = await initQuestionDB();

    await db.insert('questions', question.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Question>> getQuestionsListOnDB() async {
    final db = await initQuestionDB();

    final List<Map<String, Object?>> questionMaps = await db
        .query('questions', columns: ["rowid", "text_column", "category"]);

    return [
      for (final {
            'text_column': text as String,
            'category': category as String,
            'rowid': rowid as int,
          } in questionMaps)
        Question(text, category, isCustom: true, questionId: rowid),
    ];
  }

  Future<void> updateQuestion(Question question) async {
    final db = await initQuestionDB();

    await db.update(
      'questions',
      question.toMap(),
      where: 'rowid = ?',
      whereArgs: [question.questionId],
    );
  }

  Future<void> deleteQuestion(int id) async {
    final db = await initQuestionDB();

    await db.delete(
      'questions',
      where: 'rowid = ?',
      whereArgs: [id],
    );
  }
}
