// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptolemus/controllers/questions_controller.dart';

class AddQuestionButton extends StatelessWidget {
  final String questionText;

  AddQuestionButton({
    Key? key,
    required this.questionText,
  }) : super(key: key);

  final questionCtrl = Get.find<QuestionController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60.0,
        width: 60.0,
        child: ElevatedButton(
          onPressed: () {
            print("aca");
            if (questionText.isNotEmpty) {
              print("yesp");
              questionCtrl.addCustomQuestion(questionText);
//              textController.text = "";
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10.0), // Personaliza el radio según tus necesidades
            ),
            padding: EdgeInsets.all(0), // Ajusta el padding a 0
          ),
          child: const Icon(Icons.abc),
        ));
  }
}
