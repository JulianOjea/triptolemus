class Category {
  final String value;
  bool isActive;
  String emoji;

  Category(this.value, this.isActive, this.emoji);

  static const String picante = "Picante";
  static const String dilemas = "Dilemas";
  static const String confidenciales = "Confidenciales";
  static const String personalizadas = "Personalizadas";

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      json['name'],
      false,
      json['icon'],
    );
  }

  @override
  String toString() {
    return 'QuestionCategory(value: $value, isActive: $isActive, emoji: $emoji)';
  }
}
