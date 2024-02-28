import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/player_controller.dart';

class PlayerNameText extends StatefulWidget {
  final AnimationController animationCtrl;
  final AnimationController animationCtrlEnd;
  const PlayerNameText(
      {super.key, required this.animationCtrl, required this.animationCtrlEnd});

  @override
  State<PlayerNameText> createState() => _PlayerNameTextState();
}

class _PlayerNameTextState extends State<PlayerNameText>
    with TickerProviderStateMixin {
  final playerCtrl = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Text(
          playerCtrl.playerList[playerCtrl.index.value].name.toUpperCase(),
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 70,
              color: AppColor.contrast),
        )
            .animate(
              controller: widget.animationCtrl,
              autoPlay: false,
              onComplete: (_) {
                widget.animationCtrlEnd.forward();
                playerCtrl.nextPlayer();
                setState(() {});
              },
            )
            .moveX(
                curve: Curves.easeOutExpo, begin: 0, end: 300, duration: 700.ms)
            .then()
            .animate(controller: widget.animationCtrlEnd, autoPlay: false)
            .moveX(end: -600, duration: 0.ms)
            .moveX(curve: Curves.decelerate, end: 300, duration: 700.ms));
  }
}
