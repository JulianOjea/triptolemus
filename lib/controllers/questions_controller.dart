import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:triptolemus/data/questions.dart';
import 'package:triptolemus/models/category.dart';
import 'package:triptolemus/models/question.dart';
import 'package:triptolemus/services/category_service.dart';

class GameController extends GetxController {
  // var categories = [
  //   Category(Category.dilemas, true, '🤔'),
  //   Category(Category.picante, false, '👻'),
  //   Category(Category.confidenciales, false, '😱')
  //   //QuestionCategory(QuestionCategory.personalizadas, false, '🤯')
  // ].obs;

  var categories = <Category>[].obs;

  //List of questions
  var activeQuestions = [].obs;

  //List of custom questions
  var customQuestionList = [].obs;

  // custom question switch state
  //var insertQustomCuestion = false.obs;

  Future<void> fetchCategories() async {
    try {
      final fetchedCategories = await CategoryService.fetchCategories();
      categories.assignAll(fetchedCategories);
    } catch (e) {
      throw Exception('Unexpected error getting category');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  set database(Future<Database> database) {}

  String getQuestionString(String name) {
    final random = Random();
    Question question = activeQuestions[random.nextInt(activeQuestions.length)];
    return question.text.replaceAll("%name%", name).replaceAll('😏', name);
  }

// TODO: this refactor
  Future setActiveQuestionsList() async {
    if (customQuestionList.isEmpty) {
      var qlist = await getQuestionsListOnDB();
      customQuestionList.addAll(qlist);
    }

    activeQuestions.clear();
    if (categories[3].isActive) {
      // TODO CHANGE THIS LOGIC
      activeQuestions.addAll(customQuestionList);
    } else {
      categories.where((qc) => qc.isActive).forEach((element) {
        activeQuestions.addAll(getQuestionsByCategory(element));
        // if (insertQustomCuestion.value) {
        //   var matchlist = customQuestionList
        //       .where((customQ) => customQ.category == element.value)
        //       .toList();

        //   activeQuestions.addAll(matchlist);
        // }
      });
    }

    activeQuestions.refresh();
  }

  List<Question> getQuestionsByCategory(Category qc) {
    return Questions.questionList
        .where((element) => element.category == qc.value)
        .toList();
  }

  void addActiveCategory(Category category) {
    categories.add(category);
  }

  Category getCategoryByName(String cat) {
    return categories.firstWhere((qcat) => qcat.value == cat);
  }

  void swichActive(Category cat) {
    Category qc = getCategoryByName(cat.value);
    qc.isActive = !qc.isActive;

    // Esto era la antigua manera de cargar personalizadas
    // if (cat.value == Category.personalizadas) {
    //   categories[0].isActive = false;
    //   categories[1].isActive = false;
    //   categories[2].isActive = false;
    // } else {
    //   categories[3].isActive = false;
    // }

    categories.refresh();
  }

  void addCustomQuestion(String questionText, String qc) {
    customQuestionList.add(Question(questionText, qc, isCustom: true));
  }

  // TODO ESTA FUNCION YA NO SIRVE
  bool isAnyCatSelected() {
    return categories[0].isActive || categories[1].isActive;
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
