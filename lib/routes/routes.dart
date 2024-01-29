import 'package:flutter/material.dart';
import 'package:triptolemus/views/game_view.dart';
import 'package:triptolemus/views/players_view.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'players': (_) => PlayersView(),
  'game': (_) => GameView()
};
