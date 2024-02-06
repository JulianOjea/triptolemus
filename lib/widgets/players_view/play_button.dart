import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/player_controller.dart';
import 'package:triptolemus/widgets/main_input_text.dart';

class PlayButton extends StatelessWidget {
  List<MainInputText> playerInputList = [];
  PlayButton({super.key, required this.playerInputList});

  @override
  Widget build(BuildContext context) {
    final playerCtrl = Get.find<PlayerController>();

    return Container(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          List<MainInputText> playerNamesFiltered = playerInputList
              .where(
                  (playerInput) => playerInput.textController.text.isNotEmpty)
              .toList();

          List<String> playerNames =
              playerNamesFiltered.map((e) => e.textController.text).toList();
          playerCtrl.resetPlayerList();
          playerCtrl.fillPlayerList(playerNames);
          Get.toNamed('/configuration');
        },
        child: Container(
          decoration: const BoxDecoration(
              color: AppColor.blue2,
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
            Icons.arrow_right,
            size: 50,
            color: AppColor.orange,
          ),
        ),
      ),
    );
  }
}
