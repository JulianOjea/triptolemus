// ignore_for_file: public_member_api_docs, sort_constructors_first
class Category {
  final int id;
  final String name;
  final String emoji;
  bool isActive;

  Category(
      {required this.id,
      required this.name,
      required this.emoji,
      this.isActive = false});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      emoji: json['icon'],
    );
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name, emoji: $emoji, isActive: $isActive)';
  }

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'icon': emoji};
  }

  factory Category.fromMap(Map<String, Object?> map) {
    return Category(
      id: map['id'] as int,
      name: map['name'] as String,
      emoji: map['icon'] as String,
    );
  }
}
