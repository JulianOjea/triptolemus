import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/questions_controller.dart';
import 'package:triptolemus/widgets/main_input_text.dart';

class CustomQuestionView extends StatelessWidget {
  const CustomQuestionView({super.key});

  @override
  Widget build(BuildContext context) {
    final questionCtrl = Get.find<QuestionController>();
    final textController = TextEditingController();

    return Scaffold(
        backgroundColor: AppColor.blue,
        body: Column(
          children: [
            Obx(() => Flexible(
                child: ListView.builder(
                    itemCount: questionCtrl.customQuestionList.length,
                    itemBuilder: (_, i) => Text(
                          questionCtrl.customQuestionList[i].text,
                          style: TextStyle(fontSize: 30),
                        )))),
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: MainInputText(
                        textController: textController,
                        hintText: 'Escibe una pregunta'),
                  ),
                  Container(
                      margin:
                          const EdgeInsets.only(bottom: 15, left: 0, right: 20),
                      height: 60.0,
                      width: 60.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (textController.text.isNotEmpty) {
                            print("añadiose");
                            questionCtrl.addCustomQuestion(textController.text);
                            textController.text = "";
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
                      ))
                ],
              ),
            ),
          ],
        ));
  }
}
