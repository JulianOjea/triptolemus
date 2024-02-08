// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class QuestionContainer extends StatelessWidget {
  final String questionText;

  const QuestionContainer({
    Key? key,
    required this.questionText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      child: Text(
        questionText,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
