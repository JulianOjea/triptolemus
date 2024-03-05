import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/player_controller.dart';
import 'package:triptolemus/views/configuration_view.dart';
import 'package:triptolemus/widgets/players_view/player_list_input_text.dart';

class PlayButton extends StatelessWidget {
  PlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    final playerCtrl = Get.find<PlayerController>();

    return Container(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          playerCtrl.resetIndex();
          Get.to(() => ConfigurationView(), transition: Transition.rightToLeft);
        },
        child: Container(
          decoration: const BoxDecoration(
              color: AppColor.secondary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )),
          margin: const EdgeInsets.all(10.0),
          width: double.infinity,
          height: 60,
          child: Container(
            alignment: Alignment.centerRight,
            child: const Icon(
              Icons.navigate_next,
              size: 50,
              color: AppColor.contrast,
            ),
          ),
        ).animate().moveX(
              begin: -200,
              end: 0,
              curve: Curves.easeInCubic,
              duration: 300.ms,
            ),
      ),
    );
  }
}
