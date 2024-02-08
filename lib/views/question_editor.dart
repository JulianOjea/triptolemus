import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/questions_controller.dart';

class QuestionEditor extends StatelessWidget {
  const QuestionEditor({super.key});

  @override
  Widget build(BuildContext context) {
    final questionCtrl = Get.find<QuestionController>();
    final textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Nueva pregunta"),
      ),
      backgroundColor: AppColor.blue,
      body: Column(
        children: [
          inputFieldContainer(textController),
          confirmButton(questionCtrl, textController)
        ],
      ),
    );
  }

  SizedBox confirmButton(
      QuestionController questionCtrl, TextEditingController textController) {
    return SizedBox(
      height: 60.0,
      width: 60.0,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10.0), // Personaliza el radio según tus necesidades
            ),
            padding: const EdgeInsets.all(0), // Ajusta el padding a 0
          ),
          child: const Icon(Icons.done),
          onPressed: () {
            questionCtrl.addCustomQuestion(textController.text);
            Get.back();
          }),
    );
  }

  Container inputFieldContainer(textController) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: AppColor.orange,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: TextField(
          controller: textController,
          decoration: const InputDecoration(
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
          ),
          style: TextStyle(fontSize: 17),
          keyboardType: TextInputType.multiline,
          maxLines: 5,
        ),
      ),
    );
  }
}
