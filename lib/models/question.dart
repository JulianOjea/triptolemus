class Question {
  final String text;
  final String category;
  final bool isCustom;

  set text(String text) => this.text = text;
  Question(this.text, this.category, {this.isCustom = false});

  Map<String, Object?> toMap() {
    return {
      'text_column': text,
      'category': category,
    };
  }

  @override
  String toString() {
    return 'Question{text: $text, category: $category, isCustom: $isCustom}';
  }
}
