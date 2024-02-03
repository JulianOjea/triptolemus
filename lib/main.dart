import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:triptolemus/views/configuration_view.dart';
import 'package:triptolemus/views/custom_question_view.dart';
import 'package:triptolemus/views/game_view.dart';
import 'package:triptolemus/views/home_page_view.dart';
import 'package:triptolemus/views/players_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      initialRoute: 'home_page_view',
      getPages: [
        GetPage(
          name: '/players',
          page: () => const PlayersView(),
        ),
        GetPage(
          name: '/game',
          page: () => const GameView(),
        ),
        GetPage(
          name: '/configuration',
          page: () => const ConfigurationView(),
        ),
        GetPage(
          name: '/custom_question',
          page: () => const CustomQuestionView(),
        ),
        GetPage(
          name: '/home_page_view',
          page: () => const HomePageView(),
        )
      ],
    );
  }
}
