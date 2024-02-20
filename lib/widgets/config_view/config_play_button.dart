import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/player_controller.dart';
import 'package:triptolemus/controllers/questions_controller.dart';

class ConfigPlayButton extends StatelessWidget {
  final questionCtrl = Get.find<QuestionController>();
  final playerCtrl = Get.find<PlayerController>();
  ConfigPlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Obx(
        () => GestureDetector(
          onTap: !questionCtrl.isAnyCatSelected()
              ? null
              : () {
                  questionCtrl.setActiveQuestionsList();
                  playerCtrl.actualRound = 0;
                  playerCtrl.index.value = 0;
                  Navigator.pushNamed(context, "game");
                },
          child: Container(
            decoration: const BoxDecoration(
                color: AppColor.blue2,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                )),
            margin: const EdgeInsets.all(10.0),
            width: double.infinity,
            height: 60,
            child: Icon(
              Icons.arrow_right,
              size: 50,
              color: questionCtrl.isAnyCatSelected()
                  ? AppColor.orange
                  : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
