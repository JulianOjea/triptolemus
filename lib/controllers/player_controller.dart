import 'dart:math';

import 'package:get/get.dart';
import 'package:triptolemus/models/player.dart';

class PlayerController extends GetxController {
  final playerList = <Player>[].obs;
  var index = 0.obs;
  var actualRound = 0;
  var nRounds = 0.obs;
  var isEditingPlayer = false.obs;
  var isRandomSort = false.obs;

  bool getIsEditingPlayer() {
    return isEditingPlayer.value;
  }

  String getPlayerAtIndex(int index) {
    return playerList[index].name;
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

  bool nextRound() {
    if (actualRound <= nRounds.value * playerList.length) {
      actualRound++;
      if (actualRound == nRounds.value * playerList.length) {
        return false;
      }
    }
    return true;
  }

  void setIsEditing(isEditing) {
    isEditingPlayer.value = isEditing;
  }

  void removeAt(index) {
    playerList.removeAt(index);
  }

  void resetIndex() {
    index.value = 0;
  }

  void setPlayerValueAt(value, index) {
    playerList[index].name = value;
  }
}
