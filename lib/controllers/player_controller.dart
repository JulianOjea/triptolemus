import 'dart:math';

import 'package:get/get.dart';
import 'package:triptolemus/models/player.dart';

class PlayerController extends GetxController {
  final playerList = <Player>[].obs;
  var index = 0.obs;

  void addPlayer(Player player) {
    playerList.add(player);
  }

  void fillPlayerList(List<String> playerNames) {
    for (var playerName in playerNames) {
      playerList.add(Player(name: playerName));
    }
  }

  void resetPlayerList() {
    playerList.clear();
  }

  void nextPlayer() {
    index < playerList.length - 1 ? index.value++ : index.value = 0;
    print("Este es el indice: ${index.value}");
  }

  Player getRandomPlayerWithoutActual() {
    List<Player> tempList = List.from(playerList);
    tempList.removeAt(index.value);

    final random = Random();
    Player player = tempList[random.nextInt(tempList.length)];

    return player;
  }
}
