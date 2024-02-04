import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_detection/keyboard_detection.dart';
import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/player_controller.dart';

import 'package:triptolemus/widgets/main_input_text.dart';

class PlayersView extends StatefulWidget {
  const PlayersView({super.key});

  @override
  State<PlayersView> createState() => _PlayersViewState();
}

class _PlayersViewState extends State<PlayersView> {
  List<MainInputText> playerInputList = [];
  bool _iskeyboardVisible = false;

  @override
  void initState() {
    playerInputList.add(MainInputText(
      textController: TextEditingController(),
      hintText: 'Escribe un nombre',
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final playerCtrl = Get.put(PlayerController());

    return KeyboardDetection(
      controller: KeyboardDetectionController(onChanged: (value) {
        print("it changed: $value");
        if (value == KeyboardState.visibling) {
          _iskeyboardVisible = false;
        } else if (value == KeyboardState.hidden) {
          _iskeyboardVisible = true;
        }

        setState(() {});
      }),
      child: Scaffold(
        backgroundColor: AppColor.blue,
        body: Column(
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
                          return playerInputList[index];
                        }),
                    FloatingActionButton(
                        heroTag: "btn1",
                        child: const Icon(Icons.accessible_forward_rounded),
                        onPressed: () {
                          if (playerInputList
                              .last.textController.text.isNotEmpty) {
                            playerInputList.add(MainInputText(
                                textController: TextEditingController(),
                                hintText: 'Escribe un nombre'));
                          }
                          setState(() {});
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: !_iskeyboardVisible
                  ? null
                  : FloatingActionButton(
                      heroTag: "btn2",
                      child: const Icon(Icons.add_shopping_cart_sharp),
                      onPressed: () {
                        List<MainInputText> playerNamesFiltered =
                            playerInputList
                                .where((playerInput) =>
                                    playerInput.textController.text.isNotEmpty)
                                .toList();

                        List<String> playerNames = playerNamesFiltered
                            .map((e) => e.textController.text)
                            .toList();
                        playerCtrl.resetPlayerList();
                        playerCtrl.fillPlayerList(playerNames);
                        Get.toNamed('/configuration');
                      }),
            )
          ],
        ),
      ),
    );
  }
}
