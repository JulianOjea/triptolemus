// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';
// import 'package:triptolemus/models/question.dart';
// import 'package:triptolemus/views/question_editor.dart';

// class QuestionContainer extends StatelessWidget {
//   final Question question;

//   const QuestionContainer({Key? key, required this.question}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return qContainer();
//   }

//   GestureDetector qContainer(Question question) {
//     return GestureDetector(
//     onTap: () async {
//       var result = await Get.to(
//         () => QuestionEditor(
//           isCreating: false,
//           questionText: question.text,
//           category: question.category,
//           questionId: question.questionId!,
//         ),
//       );

//       if (result != null && result == true) {
//         getQuestions();
//       }
//     },
//     child: Container(
//       color: Colors.white,
//       margin: const EdgeInsets.all(10),
//       alignment: Alignment.centerLeft,
//       child: Text(
//         question.text,
//         style: const TextStyle(fontSize: 20),
//       ),
//     ),
//   );
//   }
// }
