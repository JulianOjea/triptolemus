import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCustomQuestionButton extends StatelessWidget {
  const HomeCustomQuestionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/custom_question'),
      child: Container(
        height: 50,
        width: 200,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
        ),
        child: const Center(
            child: Text(
          "Mis preguntas",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
