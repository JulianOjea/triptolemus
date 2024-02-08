import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/questions_controller.dart';
import 'package:triptolemus/widgets/custom_question_view/question_container.dart';
import 'package:triptolemus/widgets/custom_question_view/question_input_text.dart';
import 'package:triptolemus/widgets/main_input_text.dart';

class CustomQuestionView extends StatelessWidget {
  const CustomQuestionView({super.key});

  @override
  Widget build(BuildContext context) {
    final questionCtrl = Get.find<QuestionController>();
    final textController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text("Preguntas personalizadas"),
        ),
        backgroundColor: AppColor.blue,
        body: Column(
          children: [
            Obx(() => Flexible(
                child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                          color: Colors.black,
                        ),
                    itemCount: questionCtrl.customQuestionList.length,
                    itemBuilder: (_, i) => QuestionContainer(
                        questionText:
                            questionCtrl.customQuestionList[i].text)))),
            Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 60.0,
                  width: 60.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/question_editor');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Personaliza el radio según tus necesidades
                      ),
                      padding: EdgeInsets.all(0), // Ajusta el padding a 0
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                )),
          ],
        ));
  }
}
