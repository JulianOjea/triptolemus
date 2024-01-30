import 'dart:math';

import 'package:flutter/material.dart';
import 'package:triptolemus/data/questions.dart';
import 'package:triptolemus/models/category.dart';
import 'package:triptolemus/models/question.dart';

class QuestionService with ChangeNotifier {
  final List<QuestionCategory> _activeCategory = [];

  Question getQuestion(String name) {
    print("hola :'D");
    _activeCategory.map((e) => print(e.value));
    final random = Random();
    Question question =
        Questions.questionList[random.nextInt(Questions.questionList.length)];
    question.text.replaceAll("%name%", name);
    return Question(
        question.text.replaceAll("%name%", name), question.category);
  }

  void addActiveCategory(QuestionCategory category) {
    _activeCategory.add(category);
  }
}
