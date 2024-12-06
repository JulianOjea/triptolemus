// Future<Database> initQuestionDB() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     return openDatabase(
//       join(await getDatabasesPath(), 'question_database.db'),
//       onCreate: (db, version) {
//         return db
//             .execute('CREATE TABLE questions(text_column text, category text)');
//       },
//       version: 1,
//     );
//   }


// Future<void> insertQuestionOnDB(Question question) async {
//     final db = await initQuestionDB();

//     await db.insert('questions', question.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

// Future<List<Question>> getQuestionsListOnDB() async {
//     final db = await initQuestionDB();

//     final List<Map<String, Object?>> questionMaps = await db
//         .query('questions', columns: ["rowid", "text_column", "category"]);

//     return [
//       for (final {
//             'text_column': text as String,
//             'category': category as String,
//             'rowid': rowid as int,
//           } in questionMaps)
//         Question(text, category, isCustom: true, questionId: rowid),
//     ];
//   }

//   Future<void> updateQuestion(Question question) async {
//     final db = await initQuestionDB();

//     await db.update(
//       'questions',
//       question.toMap(),
//       where: 'rowid = ?',
//       whereArgs: [question.questionId],
//     );
//   }

//   Future<void> deleteQuestion(int id) async {
//     final db = await initQuestionDB();

//     await db.delete(
//       'questions',
//       where: 'rowid = ?',
//       whereArgs: [id],
//     );
//   }


// Future setActiveQuestionsList() async {
//     if (customQuestionList.isEmpty) {
//       var qlist = await getQuestionsListOnDB();
//       customQuestionList.addAll(qlist);
//     }

//     activeQuestions.clear();
//     if (categories[3].isActive) {
//       // TODO CHANGE THIS LOGIC
//       activeQuestions.addAll(customQuestionList);
//     } else {
//       categories.where((qc) => qc.isActive).forEach((element) {
//         activeQuestions.addAll(getQuestionsByCategory(element));
//         // if (insertQustomCuestion.value) {
//         //   var matchlist = customQuestionList
//         //       .where((customQ) => customQ.category == element.value)
//         //       .toList();

//         //   activeQuestions.addAll(matchlist);
//         // }
//       });
//     }

//     activeQuestions.refresh();
//   }