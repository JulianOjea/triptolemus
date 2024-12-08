class Query {
  static const String questionDB = 'question_database.db';
  static const String questionTable = 'questions';
  static const String createQuestionTable =
      'CREATE TABLE $questionTable(id int, text text, category_id int)';
  static const String countQuestionsQuery = 'SELECT COUNT(*) FROM questions';

  static const String categoryDB = 'category_database.db';
  static const String categoryTable = 'category';
  static const String createCategoryTable =
      'CREATE TABLE $categoryTable(id int, name text, icon string)';
  static const String countCategoryQuery = 'SELECT COUNT(*) FROM category';
}
