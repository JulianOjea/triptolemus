import 'dart:math';

import 'package:get/get.dart';
import 'package:triptolemus/data/questions.dart';
import 'package:triptolemus/models/category.dart';
import 'package:triptolemus/models/question.dart';

class QuestionController extends GetxController {
  var categories = [
    QuestionCategory(QuestionCategory.dilemas, true),
    QuestionCategory(QuestionCategory.personalizada, false),
    QuestionCategory(QuestionCategory.picante, false),
    QuestionCategory(QuestionCategory.confidenciales, false),
  ].obs;

  var activeQuestions = [].obs;

  String getQuestionString(String name) {
    final random = Random();
    Question question = activeQuestions[random.nextInt(activeQuestions.length)];
    return question.text.replaceAll("%name%", name);
  }

  void setActiveQuestionsList() {
    activeQuestions.clear();

    categories.where((qc) => qc.isActive).forEach((element) {
      activeQuestions.addAll(getQuestionsByCategory(element));
    });
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
    categories.refresh();
  }
}
