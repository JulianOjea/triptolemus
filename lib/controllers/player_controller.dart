import 'dart:math';

import 'package:get/get.dart';
import 'package:triptolemus/models/player.dart';

class PlayerController extends GetxController {
  final playerList = <Player>[].obs;
  var index = 0.obs;
  var actualRound = 0;
  var nRounds = 0.obs;
  var isEditingPlayer = false.obs;

  bool getIsEditingPlayer() {
    return isEditingPlayer.value;
  }

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
  }

  Player getRandomPlayerWithoutActual() {
    List<Player> tempList = List.from(playerList);
    tempList.removeAt(index.value);

    final random = Random();
    Player player = tempList[random.nextInt(tempList.length)];

    return player;
  }

  void nextRound() {
    if (index.value == playerList.length - 1) {
      actualRound++;
      if (actualRound == nRounds.value) {
        print("Ahora se acaba el juego");
      }
    }
  }

  void setIsEditing(isEditing) {
    isEditingPlayer.value = isEditing;
  }
}
