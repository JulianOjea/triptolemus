// ignore_for_file: public_member_api_docs, sort_constructors_first
class Question {
  final int questionId;
  final String text;
  final int categoryId;
  final bool isCustom;

  set text(String text) => this.text = text;

  Question(
      {required this.questionId,
      required this.text,
      required this.categoryId,
      this.isCustom = false});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        questionId: json['id'],
        text: json['text'],
        categoryId: json['category_id']);
  }

  //TODO ??
  //Esto se usaba para insertar en base de datos
  Map<String, Object?> toMap() {
    return {'id': questionId, 'text': text, 'category_id': categoryId};
  }

  factory Question.fromMap(Map<String, Object?> map) {
    return Question(
      questionId: map['id'] as int,
      text: map['text'] as String,
      categoryId: map['category_id'] as int,
    );
  }

  @override
  String toString() {
    return 'Question(questionId: $questionId, text: $text, categoryId: $categoryId, isCustom: $isCustom)';
  }
}
