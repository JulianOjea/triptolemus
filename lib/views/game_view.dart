import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triptolemus/services/player_service.dart';
import 'package:triptolemus/widgets/RequestContainer.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    final playerService = Provider.of<PlayerList>(context);
    RequestContainer rc = RequestContainer();

    return Scaffold(
      backgroundColor: Color.fromRGBO(110, 205, 230, 1.000),
      body: Center(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                playerService.playerList[playerService.index].name
                    .toUpperCase(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 70,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 100,
              ),
              rc,
            ],
          )),
        ),
      ),
    );
  }
}
