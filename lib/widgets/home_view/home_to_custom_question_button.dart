import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/views/custom_question_view.dart';

class HomeCustomQuestionButton extends StatelessWidget {
  const HomeCustomQuestionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Get.to(() => const CustomQuestionView(), transition: Transition.size),
      child: Container(
        height: 50,
        width: 200,
        decoration: const BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
        ),
        child: Center(
            child: Text(
          'welcome'.tr,
          style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColor.contrast),
        )),
      ),
    );
  }
}
