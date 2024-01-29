import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triptolemus/constants/colors.dart';

import 'package:triptolemus/services/player_service.dart';
import 'package:triptolemus/widgets/PlayerInput.dart';

class PlayersView extends StatefulWidget {
  const PlayersView({super.key});

  @override
  State<PlayersView> createState() => _PlayersViewState();
}

class _PlayersViewState extends State<PlayersView> {
  List<PlayerInput> playerInputList = [];

  @override
  void initState() {
    playerInputList.add(PlayerInput(
      textController: TextEditingController(),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final playerList = Provider.of<PlayerList>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColor.blue,
      body: Center(
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
                    if (playerInputList.last.textController.text.isNotEmpty) {
                      playerInputList.add(PlayerInput(
                        textController: TextEditingController(),
                      ));
                    }
                    setState(() {});
                  }),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                  heroTag: "btn2",
                  child: const Icon(Icons.add_shopping_cart_sharp),
                  onPressed: () {
                    List<String> playerNames = playerInputList
                        .map((playerInput) => playerInput.textController.text)
                        .toList();
                    playerNames.removeLast();
                    playerList.resetPlayerList();
                    playerList.fillPlayerList(playerNames);
                    Navigator.pushNamed(context, "configuration");
                  })
            ],
          ),
        ),
      ),
    );
  }
}
