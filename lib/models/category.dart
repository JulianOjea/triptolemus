class QuestionCategory {
  final String value;

  const QuestionCategory(this.value);

  static const QuestionCategory dilemas = QuestionCategory("Dilemas");
  static const QuestionCategory picante = QuestionCategory("Picante");
  static const QuestionCategory confidenciales =
      QuestionCategory("Confidenciales");
  static const QuestionCategory personalizada =
      QuestionCategory("Personalizada");
}
