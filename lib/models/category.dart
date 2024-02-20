//   static const QuestionCategory dilemas = QuestionCategory("Dilemas");
//   static const QuestionCategory picante = QuestionCategory("Picante");
//   static const QuestionCategory confidenciales =
//       QuestionCategory("Confidenciales");
//   static const QuestionCategory personalizada =
//       QuestionCategory("Personalizada");
// }
class QuestionCategory {
  final String value;
  bool isActive;

  QuestionCategory(this.value, this.isActive);

  static const String picante = "Picante";
  static const String dilemas = "Dilemas";
  static const String confidenciales = "Confidenciales";
  static const String personalizadas = "Personalizadas";
}
