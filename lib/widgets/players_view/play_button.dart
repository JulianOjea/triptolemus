import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/player_controller.dart';
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
          Get.toNamed('/configuration');
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
          child: const Icon(
            Icons.settings,
            size: 50,
            color: AppColor.contrast,
          ),
        ),
      ),
    );
  }
}
