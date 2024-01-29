import 'dart:math';

class Questions {
  static String getQuestion(String name) {
    final random = Random();
    String question =
        Questions.questionList[random.nextInt(Questions.questionList.length)];
    return question.replaceAll("%name%", name);
  }

  static List<String> questionList = [
    "Question 1 %name%",
    "Question 2 Question 2 Question 2 Question 2 Question 2 Question 2 %name%",
    "Question 3 Question 3 Question 3 %name%",
    "Question 4 Question 4 Question 4 Question 4 Question 4 Question 4 Question 4 Question 4 %name%"
  ];
}
