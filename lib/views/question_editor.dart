import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_detection/keyboard_detection.dart';
import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/questions_controller.dart';

class QuestionEditor extends StatefulWidget {
  const QuestionEditor({super.key});

  @override
  State<QuestionEditor> createState() => _QuestionEditorState();
}

class _QuestionEditorState extends State<QuestionEditor> {
  final textController = TextEditingController();
  bool isEditing = false;
  var fieldvalue = "";

  @override
  Widget build(BuildContext context) {
    final questionCtrl = Get.find<QuestionController>();

    return KeyboardDetection(
      controller: KeyboardDetectionController(onChanged: (value) {
        if (value == KeyboardState.visibling) {
          isEditing = true;
          //playerCtrl.isEditingPlayer
        } else if (value == KeyboardState.hiding) {
          isEditing = false;
        }
        setState(() {});
      }),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Nueva pregunta"),
        ),
        backgroundColor: AppColor.blue,
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  inputFieldContainer(textController),
                  confirmButton(questionCtrl, textController),
                ],
              ),
            ),
            if (isEditing) placeHolderContainer(),
          ],
        ),
      ),
    );
  }

  GestureDetector placeHolderContainer() {
    return GestureDetector(
      onTap: () {
        setState(() {
          textController.text += " 😏";
        });
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 60,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: AppColor.orange,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: const Center(
            child: Text(
          '😏',
          style: TextStyle(fontSize: 40),
        )),
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
            if (textController.text.isNotEmpty) {
              questionCtrl.addCustomQuestion(textController.text);
            }
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
