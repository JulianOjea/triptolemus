import 'dart:math';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import 'package:triptolemus/models/category.dart';
import 'package:triptolemus/models/question.dart';

import 'package:triptolemus/services/api/category_service.dart';
import 'package:triptolemus/services/api/question_service.dart';
import 'package:triptolemus/services/db/category_repository.dart';
import 'package:triptolemus/services/db/question_repository.dart';

class GameController extends GetxController {
  // var categories = [
  //   Category(Category.dilemas, true, '🤔'),
  //   Category(Category.picante, false, '👻'),
  //   Category(Category.confidenciales, false, '😱')
  //   //QuestionCategory(QuestionCategory.personalizadas, false, '🤯')
  // ].obs;

  var categories = <Category>[].obs;

  //List of questions
  var questionList = <Question>[].obs;

  //List of active questions
  var activeQuestions = <Question>[].obs;

  //List of custom questions
  var customQuestionList = <Question>[].obs;

  // custom question switch state
  //var insertQustomCuestion = false.obs;

  Future<List<Category>> fetchCategories() async {
    try {
      List<Category> fetchedCategories =
          await CategoryService.fetchCategories();
      return fetchedCategories;
    } catch (e) {
      throw Exception('Unexpected error getting category');
    }
  }

  Future<List<Question>> fetchQuestions() async {
    try {
      List<Question> fetchedQuestions = await QuestionService.fetchQuestions();
      return fetchedQuestions;
    } catch (e) {
      throw Exception('Unexpected error fetching questions from internet');
    }
  }

  Future<void> initQuestionDB() async {
    try {
      QuestionRepository.initDB();
      var questionCount = await QuestionRepository.getQuestionCount();
      print("This is the amount of questions: $questionCount");
      // If data base is empty fetch questions from internet
      if (questionCount == 0) {
        print("Inserting questions on db");
        List<Question> questionList = await fetchQuestions();
        QuestionRepository.insertQuestionListOnDB(questionList);
      }
    } catch (e) {
      throw Exception('Error getting question db');
    }
  }

  Future<void> initCategoryDB() async {
    try {
      CategoryRepository.initDB();
      var categoryCount = await CategoryRepository.getCategoryCount();
      print("This is the amount of categories: $categoryCount");
      // If data base is empty fetch categories from internet
      if (categoryCount == 0) {
        print("Inserting categories on db");
        List<Category> categoryList = await fetchCategories();
        CategoryRepository.insertCategoryListOnDB(categoryList);
      }
    } catch (e) {
      throw Exception('Error getting category db');
    }
  }

  Future<void> initQuestionList() async {
    print("adding questions to list from db");
    List<Question> dbQuestionList = await QuestionRepository.getQuestionList();
    questionList.assignAll(dbQuestionList);
    print("Size of question List: ${questionList.length}");
  }

  Future<void> initCategoryList() async {
    print("adding category to list from db");
    List<Category> dbCategoryList = await CategoryRepository.getCategoryList();
    categories.assignAll(dbCategoryList);
    print("Size of category List: ${categories.length}");
  }

  @override
  void onInit() async {
    super.onInit();
    //First initialize db if needed: fetch if needed + save on db if needed
    initQuestionDB();
    initQuestionList();

    initCategoryDB();
    initCategoryList();
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
    return categories[0].isActive ||
        categories[1].isActive ||
        categories[2].isActive;
  }
}
