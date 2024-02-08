// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:triptolemus/constants/colors.dart';

class QuestionIputText extends StatelessWidget {
  final TextEditingController textController;

  const QuestionIputText({
    Key? key,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        color: AppColor.orange,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black.withOpacity(0.10),
              offset: const Offset(0, 10),
              blurRadius: 5),
        ],
      ),
      child: TextField(
        controller: textController,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: "Escribe una pregunta"),
      ),
    );
  }
}
