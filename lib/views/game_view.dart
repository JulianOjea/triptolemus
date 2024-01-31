import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/player_controller.dart';
import 'package:triptolemus/widgets/request_container.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final playerCtrl = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    RequestContainer rc = RequestContainer();

    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColor.blue,
        body: Center(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                      playerCtrl.playerList[playerCtrl.index.value].name
                          .toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 70,
                          color: Colors.white)),
                ),
                const SizedBox(
                  height: 100,
                ),
                rc,
              ],
            )),
          ),
        ),
      ),
    );
  }
}
