// ignore_for_file: public_member_api_docs, sort_constructors_first
class Question {
  final int questionId;
  final String textEs;
  final String textEng;
  final int categoryId;
  final bool isCustom;

  set textEs(String text) => textEs = text;
  set textEng(String text) => textEng = text;

  Question(
      {required this.questionId,
      required this.textEs,
      required this.textEng,
      required this.categoryId,
      this.isCustom = false});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        questionId: json['id'],
        textEs: json['text_es'],
        textEng: json['text_eng'],
        categoryId: json['category_id']);
  }

  //TODO ??
  //Esto se usaba para insertar en base de datos
  Map<String, Object?> toMap() {
    return {
      'id': questionId,
      'text_es': textEs,
      'text_eng': textEng,
      'category_id': categoryId
    };
  }

  factory Question.fromMap(Map<String, Object?> map) {
    return Question(
      questionId: map['id'] as int,
      textEs: map['text_es'] as String,
      textEng: map['text_eng'] as String,
      categoryId: map['category_id'] as int,
    );
  }

  @override
  String toString() {
    return 'Question(questionId: $questionId, text_es: $textEs, text_eng: $textEng, categoryId: $categoryId, isCustom: $isCustom)';
  }
}
