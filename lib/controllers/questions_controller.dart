import 'dart:math';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import 'package:triptolemus/models/category.dart';
import 'package:triptolemus/models/question.dart';

import 'package:triptolemus/services/api/category_service.dart';
import 'package:triptolemus/services/api/question_service.dart';

class GameController extends GetxController {
  // var categories = [
  //   Category(Category.dilemas, true, '🤔'),
  //   Category(Category.picante, false, '👻'),
  //   Category(Category.confidenciales, false, '😱')
  //   //QuestionCategory(QuestionCategory.personalizadas, false, '🤯')
  // ].obs;

  var categories = <Category>[].obs;

  //List of questions
  var questionList = [].obs;

  //List of active questions
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

  Future<void> fetchQuestions() async {
    try {
      final fetchedQuestions = await QuestionService.fetchQuestions();
      questionList.assignAll(fetchedQuestions);
    } catch (e) {
      throw Exception('Unexpected error getting question');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchQuestions();
  }

  set database(Future<Database> database) {}

  String getQuestionString(String name) {
    final random = Random();
    Question question = activeQuestions[random.nextInt(activeQuestions.length)];
    return question.text.replaceAll("%name%", name).replaceAll('😏', name);
  }

// TODO: this refactor
  Future setActiveQuestionsList() async {
    activeQuestions.clear();
    for (var category in categories) {
      if (category.isActive) {
        var testq = questionList.where((q) => q.categoryId == category.id);
        activeQuestions.addAll(testq);
      }
    }
    activeQuestions.refresh();
  }

  // List<Question> getQuestionsByCategory(Category qc) {
  //   return Questions.questionList
  //       .where((element) => element.category == qc.value)
  //       .toList();
  // }

  void addActiveCategory(Category category) {
    categories.add(category);
  }

  Category getCategoryByName(String cat) {
    return categories.firstWhere((qcat) => qcat.name == cat);
  }

  void swichActive(Category cat) {
    Category qc = getCategoryByName(cat.name);
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

  // void addCustomQuestion(String questionText, String qc) {
  //   customQuestionList.add(Question(questionText, qc, isCustom: true));
  // }

  // TODO ESTA FUNCION YA NO SIRVE
  bool isAnyCatSelected() {
    return categories[0].isActive || categories[1].isActive;
  }
}
