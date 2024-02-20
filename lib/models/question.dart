class Question {
  final String text;
  final String category;
  final bool isCustom;

  set text(String text) => this.text = text;
  Question(this.text, this.category, {this.isCustom = false});
}
