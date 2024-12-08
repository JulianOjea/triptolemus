import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:triptolemus/constants/query.dart';
import 'package:triptolemus/models/category.dart';

class CategoryRepository {
  static Future<Database> _openDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), Query.categoryDB),
    );
  }

  static Future<Database> initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), Query.categoryDB),
      onCreate: (db, version) {
        print("creating Category db");
        return db.execute(Query.createCategoryTable);
      },
      version: 1,
    );
  }

  static Future<void> insertCategoryOnDB(Category category) async {
    Database db = await _openDB();
    await db.insert(Query.categoryTable, category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> insertCategoryListOnDB(
      List<Category> categoryList) async {
    Database db = await _openDB();
    print("Inserting category List on db");
    for (var category in categoryList) {
      await db.insert(Query.categoryTable, category.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  static Future<int> getCategoryCount() async {
    Database db = await _openDB();
    var result = await db.rawQuery(Query.countCategoryQuery);
    return Sqflite.firstIntValue(result) ?? 0;
  }

  static Future<List<Category>> getCategoryList() async {
    Database db = await _openDB();
    final List<Map<String, Object?>> categoryMaps =
        await db.query(Query.categoryTable);
    return [
      for (final map in categoryMaps) Category.fromMap(map),
    ];
  }
}
