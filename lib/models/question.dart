class Question {
  int? questionId;
  final String text;
  final String category;
  final bool isCustom;

  set text(String text) => this.text = text;
  Question(this.text, this.category, {this.isCustom = false, this.questionId});

  Map<String, Object?> toMap() {
    return {
      'rowid': questionId,
      'text_column': text,
      'category': category,
    };
  }

  @override
  String toString() {
    return 'Question{id: $questionId text: $text, category: $category, isCustom: $isCustom}';
  }
}
