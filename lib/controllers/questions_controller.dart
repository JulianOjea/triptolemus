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

  Question getQuestion(String name) {
    categories.map((e) => print(e.value));
    final random = Random();
    Question question =
        Questions.questionList[random.nextInt(Questions.questionList.length)];
    question.text.replaceAll("%name%", name);
    return Question(
        question.text.replaceAll("%name%", name), question.category);
  }

  void addActiveCategory(QuestionCategory category) {
    categories.add(category);
  }

  bool isActive(String cat) {
    //TODO
    return true;
  }
}
