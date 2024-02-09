import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/player_controller.dart';
import 'package:triptolemus/controllers/questions_controller.dart';

class RequestContainer extends StatefulWidget {
  const RequestContainer({
    super.key,
  });

  @override
  State<RequestContainer> createState() => _RequestContainerState();
}

class _RequestContainerState extends State<RequestContainer>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final playerCrtl = Get.find<PlayerController>();
    final questionCrtl = Get.find<QuestionController>();
    var animationCtrl = AnimationController(vsync: this);

    return Column(
      children: [
        animatedContainer(questionCrtl, playerCrtl, animationCtrl),
        const SizedBox(
          height: 50,
        ),
        FloatingActionButton(
            child: const Icon(Icons.add_road),
            onPressed: () {
              playerCrtl.nextPlayer();
              playerCrtl.nextRound();
              animationCtrl.forward();
              setState(() {});
            })
      ],
    );
  }

  Animate animatedContainer(QuestionController questionCrtl,
      PlayerController playerCrtl, AnimationController animationCtrl) {
    return Animate(
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.orange, borderRadius: BorderRadius.circular(20.0)),
        width: 300,
        height: 300,
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            questionCrtl.getQuestionString(
                playerCrtl.getRandomPlayerWithoutActual().name),
            style: const TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      )
          .animate(controller: animationCtrl)
          .move(
              // duration: 1000.ms,
              curve: Curves.elasticInOut,
              end: Offset(400, -200),
              duration: 1000.ms)
          .then()
          .moveX(end: -800, duration: Duration.zero)
          .then()
          .move(
              curve: Curves.elasticInOut,
              end: Offset(400, 200),
              duration: 700.ms),
    );
  }
}
