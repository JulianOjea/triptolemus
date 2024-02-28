import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_detection/keyboard_detection.dart';
import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/player_controller.dart';
import 'package:triptolemus/controllers/questions_controller.dart';
import 'package:triptolemus/models/player.dart';

import 'package:triptolemus/widgets/main_input_text.dart';
import 'package:triptolemus/widgets/players_view/play_button.dart';
import 'package:triptolemus/widgets/players_view/player_list_input_text.dart';

class PlayersView extends StatefulWidget {
  const PlayersView({super.key});

  @override
  State<PlayersView> createState() => _PlayersViewState();
}

class _PlayersViewState extends State<PlayersView> {
  bool _isGoToConfigVisible = true;

  //TODO MAYBE YOU CAN DO LAZY PUT HERE
  //TODO ON HIDE EDIT NEEDS TO BE IMPROVED
  final questionCtrl = Get.find<QuestionController>();
  final playerCtrl = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    setState(() {});
    final mainTextController = TextEditingController();
    return KeyboardDetection(
      controller: KeyboardDetectionController(onChanged: (value) {
        if (value == KeyboardState.visibling) {
          _isGoToConfigVisible = false;
          //playerCtrl.isEditingPlayer
        } else if (value == KeyboardState.hiding) {
          _isGoToConfigVisible = true;
          playerCtrl.setIsEditing(false);
        }

        setState(() {});
      }),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: AppColor.contrast, //change your color here
          ),
          centerTitle: true,
          backgroundColor: AppColor.background,
          title: const Text(
            "Jugadores",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: AppColor.contrast),
          ),
        ),
        backgroundColor: AppColor.background,
        body: Obx(
          () {
            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Column(
                children: [
                  playerCtrl.playerList.isEmpty
                      ? placeholderNotEnoughPlayers()
                      : playerNameList(),
                  if (!playerCtrl.isEditingPlayer.value)
                    inputRow(mainTextController),
                  Obx(() {
                    if (playerCtrl.playerList.length <= 1) {
                      return Container();
                    } else {
                      if (_isGoToConfigVisible) {
                        return PlayButton();
                      } else {
                        return Container();
                      }
                    }
                  })
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Expanded placeholderNotEnoughPlayers() {
    return const Expanded(
        child: Center(
            child: Text(
      "Añade 2 jugadores para jugar 😀",
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.contrast),
    )));
  }

  Expanded playerNameList() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: playerCtrl.playerList.length,
                itemBuilder: (_, int index) {
                  String playerName = playerCtrl.getPlayerAtIndex(index);
                  return Dismissible(
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      //print("i did it $index");
                      playerCtrl.removeAt(index);
                    },
                    key: Key(playerName),
                    background: Container(
                      margin: const EdgeInsets.fromLTRB(0, 10.0, 10.0, 0.0),
                      color: AppColor.secondary,
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    child: Container(
                        margin:
                            const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        child: PlayerListInputText(
                            index: index,
                            textController: TextEditingController(
                              text: playerCtrl.getPlayerAtIndex(index),
                            ))),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Container inputRow(TextEditingController mainTextController) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Flexible(
            child: MainInputText(
                textController: mainTextController,
                hintText: 'Escribe un nombre',
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                )),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            height: 60,
            child: FittedBox(
              child: FloatingActionButton(
                  backgroundColor: AppColor.secondary,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  )),
                  child: const Icon(
                    Icons.add,
                    color: AppColor.contrast,
                  ),
                  onPressed: () {
                    if (mainTextController.text.isNotEmpty) {
                      playerCtrl
                          .addPlayer(Player(name: mainTextController.text));
                      // playerInputList.add(PlayerListInputText(
                      //     textController: TextEditingController(
                      //         text: mainTextController.text)));
                    } else {
                      playerCtrl.addPlayer(Player(
                          name: "Jugador ${playerCtrl.playerList.length + 1}"));
                    }
                    mainTextController.clear();
                    setState(() {});
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
