import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/player_controller.dart';
import 'package:triptolemus/controllers/questions_controller.dart';
import 'package:triptolemus/views/game_view.dart';

class ConfigPlayButton extends StatelessWidget {
  final questionCtrl = Get.find<GameController>();
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
              : () async {
                  await questionCtrl.setActiveQuestionsList();
                  playerCtrl.actualRound = 0;
                  playerCtrl.resetIndex();
                  Get.to(() => const GameView(),
                      transition: Transition.upToDown);
                },
          child: AnimatedGradientBorder(
            borderSize: 2,
            glowSize: 2,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            gradientColors: questionCtrl.isAnyCatSelected()
                ? const [
                    Colors.redAccent,
                    AppColor.contrast,
                    Colors.yellow,
                    AppColor.secondary,
                  ]
                : const [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                  ],
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
              padding: const EdgeInsets.all(0),
              width: double.infinity,
              height: 60,
              child: Icon(
                Icons.arrow_right,
                size: 60,
                color: questionCtrl.isAnyCatSelected()
                    ? AppColor.contrast
                    : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
