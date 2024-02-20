import 'dart:math';

import 'package:get/get.dart';
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
}
