import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_detection/keyboard_detection.dart';
import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/questions_controller.dart';
import 'package:triptolemus/models/category.dart';
import 'package:triptolemus/models/question.dart';

class QuestionEditor extends StatefulWidget {
  final bool isCreating;
  final String questionText;
  final String category;
  final int questionId;

  const QuestionEditor(
      {super.key,
      this.isCreating = true,
      this.questionText = "",
      this.category = "",
      this.questionId = 0});

  @override
  State<QuestionEditor> createState() => _QuestionEditorState();
}

class _QuestionEditorState extends State<QuestionEditor> {
  final textController = TextEditingController();
  bool isEditing = false;
  var fieldvalue = "";
  String selectedContainer = QuestionCategory.dilemas;

  @override
  void initState() {
    super.initState();

    if (!widget.isCreating) {
      textController.text = widget.questionText;
      selectedContainer = widget.category;
    }
  }

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
          title: const Text("Nueva pregunta"),
          actions: !widget.isCreating
              ? [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      questionCtrl.deleteQuestion(widget.questionId);
                      Get.back(result: true);
                    },
                  )
                ]
              : [],
        ),
        backgroundColor: AppColor.blue,
        body: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Column(
                  children: [
                    inputFieldContainer(textController),
                    if (!isEditing) Expanded(child: categorySelector()),
                    if (!isEditing) confirmButton(questionCtrl, textController),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
            if (isEditing) placeHolderContainer(),
          ],
        ),
      ),
    );
  }

  Container categorySelector() {
    return Container(
      child: Column(
        children: [
          containerSelector(QuestionCategory.dilemas, '🤔'),
          containerSelector(QuestionCategory.picante, '👻'),
          containerSelector(QuestionCategory.confidenciales, '😱'),
        ],
      ),
    );
  }

  GestureDetector containerSelector(container_text, emoji) {
    return GestureDetector(
      onTap: () {
        selectedContainer = container_text;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: selectedContainer == container_text
                ? Colors.white
                : AppColor.orange,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(start: 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  emoji,
                  style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                container_text,
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  GestureDetector placeHolderContainer() {
    return GestureDetector(
      onTap: () {
        setState(() {
          textController.text += "😏";
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
          onPressed: () async {
            if (textController.text.isNotEmpty) {
              if (widget.isCreating) {
                // questionCtrl.addCustomQuestion(
                //     textController.text, selectedContainer);
                Question q = Question(textController.text, selectedContainer,
                    isCustom: true);
                questionCtrl.insertQuestionOnDB(q);
              } else {
                Question q = Question(textController.text, selectedContainer,
                    isCustom: true, questionId: widget.questionId);
                await questionCtrl.updateQuestion(q);
              }
            } else {
              //TODO DO SOMETHING WHEN IS EMPTY
            }
            print("lo hace");
            Get.back(result: true);
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
