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
  List<PlayerListInputText> playerInputList = [];
  bool _iskeyboardVisible = false;

  //TODO MAYBE YOU CAN DO LAZY PUT HERE
  //TODO ON HIDE EDIT NEEDS TO BE IMPROVED
  final questionCtrl = Get.put(QuestionController());
  final playerCtrl = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    setState(() {});
    final mainTextController = TextEditingController();

    return KeyboardDetection(
      controller: KeyboardDetectionController(onChanged: (value) {
        if (value == KeyboardState.visibling) {
          print("ME MUESTROO");
          _iskeyboardVisible = false;
          //playerCtrl.isEditingPlayer
        } else if (value == KeyboardState.hidden) {
          print("ME OCULTOO ");
          _iskeyboardVisible = true;
          playerCtrl.setIsEditing(false);
        }

        setState(() {});
      }),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(110, 205, 230, 1),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: playerInputList.length,
                          itemBuilder: (_, int index) {
                            final item = playerInputList[index];
                            return Dismissible(
                              direction: DismissDirection.startToEnd,
                              onDismissed: (direction) {
                                playerInputList.removeAt(index);
                              },
                              key: Key(item.textController.text),
                              background: Container(
                                margin: const EdgeInsets.fromLTRB(
                                    0, 10.0, 10.0, 0.0),
                                color: AppColor.red,
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              child: Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      10.0, 10.0, 10.0, 0.0),
                                  child: playerInputList[index]),
                            );
                          }),
                    ],
                  ),
                ),
              ),
              if (!playerCtrl.isEditingPlayer.value)
                inputRow(mainTextController),
              if (_iskeyboardVisible)
                PlayButton(
                  playerInputList: playerInputList,
                ),
            ],
          ),
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
                  backgroundColor: AppColor.red,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  )),
                  child: const Icon(Icons.add),
                  onPressed: () {
                    if (mainTextController.text.isNotEmpty) {
                      playerCtrl
                          .addPlayer(Player(name: mainTextController.text));
                      playerInputList.add(PlayerListInputText(
                          textController: TextEditingController(
                              text: mainTextController.text)));
                      mainTextController.clear();
                    }
                    setState(() {});
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
