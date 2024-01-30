import 'package:triptolemus/models/category.dart';

class Question {
  final String text;
  final QuestionCategory category;

  set text(String text) => this.text = text;
  Question(this.text, this.category);
}
