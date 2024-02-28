// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/player_controller.dart';
import 'package:triptolemus/controllers/questions_controller.dart';

class RequestContainer extends StatefulWidget {
  final AnimationController animationTextCtrl;
  final AnimationController animationTextCtrlEnd;
  const RequestContainer(
      {Key? key,
      required this.animationTextCtrl,
      required this.animationTextCtrlEnd})
      : super(key: key);

  @override
  State<RequestContainer> createState() => _RequestContainerState();
}

class _RequestContainerState extends State<RequestContainer>
    with TickerProviderStateMixin {
  late AnimationController _animationCtrl;
  late AnimationController _animationCtrlEnd;

  final playerCrtl = Get.find<PlayerController>();
  final questionCrtl = Get.find<QuestionController>();
  late String questionText;
  var _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _animationCtrl = AnimationController(vsync: this);
    _animationCtrlEnd = AnimationController(vsync: this);
    questionText = questionCrtl
        .getQuestionString(playerCrtl.getRandomPlayerWithoutActual().name);
  }

  @override
  void dispose() {
    _animationCtrl.dispose();
    _animationCtrlEnd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: !_isAnimating
                ? () {
                    _isAnimating = true;
                    setState(() {});
                    if (playerCrtl.nextRound()) {
                      _animationCtrl.reset();
                      _animationCtrl.forward();
                      widget.animationTextCtrl.reset();
                      widget.animationTextCtrlEnd.reset();
                      widget.animationTextCtrl.forward();
                    } else {
                      Navigator.pushNamed(context, "configuration");
                    }
                  }
                : null,
            child: animatedContainer(questionCrtl, playerCrtl, _animationCtrl)),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }

  Animate animatedContainer(QuestionController questionCrtl,
      PlayerController playerCrtl, AnimationController animationCtrl) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.primary, borderRadius: BorderRadius.circular(20.0)),
      width: 300,
      height: 300,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Center(
        child: AutoSizeText(
          textAlign: TextAlign.center,
          questionText,
          maxLines: 6,
          minFontSize: 20.0,
          style: const TextStyle(
              color: AppColor.contrast,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ),
    )
        .animate(
            controller: animationCtrl,
            autoPlay: false,
            onComplete: (_) {
              _isAnimating = false;
              setState(() {});
            })
        .move(
            curve: Curves.elasticInOut,
            end: const Offset(400, -200),
            duration: 1000.ms)
        .callback(
            duration: 1000.ms,
            callback: (flag) {
              //TODO: WHAT IS THIS CALLBACK FLAG TRICK XDD
              if (flag == false) {
                questionText = questionCrtl.getQuestionString(
                    playerCrtl.getRandomPlayerWithoutActual().name);
                setState(() {});
              }
            })
        .then()
        .moveX(
          end: -800,
          duration: Duration.zero,
        )
        .then()
        .move(
            curve: Curves.elasticOut,
            end: const Offset(400, 200),
            duration: 700.ms);
  }
}
