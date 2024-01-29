import 'dart:math';

import 'package:flutter/material.dart';
import 'package:triptolemus/models/player.dart';

class PlayerList with ChangeNotifier {
  final List<Player> _playerList = [];
  int _index = 0;

  List<Player> get playerList => _playerList;
  int get index => _index;

  set index(int index) => _index = index;

  void addPlayer(Player player) {
    _playerList.add(player);
  }

  void fillPlayerList(List<String> playerNames) {
    for (var playerName in playerNames) {
      _playerList.add(Player(name: playerName));
    }
  }

  void resetPlayerList() {
    _playerList.clear();
  }

  void nextPlayer() {
    _index < _playerList.length - 1 ? _index++ : _index = 0;
    notifyListeners();
  }

  Player getRandomPlayerWithoutActual() {
    List<Player> tempList = List.from(_playerList);
    tempList.removeAt(index);

    final random = Random();
    Player player = tempList[random.nextInt(tempList.length)];

    return player;
  }
}
