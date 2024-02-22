import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/questions_controller.dart';
import 'package:triptolemus/models/question.dart';
import 'package:triptolemus/views/question_editor.dart';
import 'package:triptolemus/widgets/custom_question_view/question_container.dart';

class CustomQuestionView extends StatefulWidget {
  const CustomQuestionView({super.key});

  @override
  State<CustomQuestionView> createState() => _CustomQuestionViewState();
}

class _CustomQuestionViewState extends State<CustomQuestionView> {
  final questionCtrl = Get.find<QuestionController>();

  late List<Question> qlist;

  getQuestions() async {
    qlist = await questionCtrl.getQuestionsListOnDB();
    questionCtrl.customQuestionList.clear();
    questionCtrl.customQuestionList.addAll(qlist);
  }

  @override
  Widget build(BuildContext context) {
    getQuestions();
    return Scaffold(
      appBar: AppBar(
        title: Text("Preguntas personalizadas"),
      ),
      backgroundColor: AppColor.blue,
      body: FutureBuilder(
        future: getQuestions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return Column(
              children: [
                Obx(
                  () => Flexible(
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        color: Colors.black,
                      ),
                      itemCount: questionCtrl.customQuestionList.length,
                      itemBuilder: (_, i) {
                        return qContainer(questionCtrl.customQuestionList[i]);
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 60.0,
                    width: 60.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        var result = await Get.toNamed('/question_editor');

                        if (result != null && result == true) {
                          getQuestions();
                        }
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
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  GestureDetector qContainer(Question question) {
    return GestureDetector(
      onTap: () async {
        var result = await Get.to(
          () => QuestionEditor(
            isCreating: false,
            questionText: question.text,
            category: question.category,
            questionId: question.questionId!,
          ),
        );

        if (result != null && result == true) {
          getQuestions();
        }
      },
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.all(10),
        alignment: Alignment.centerLeft,
        child: Text(
          question.text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
