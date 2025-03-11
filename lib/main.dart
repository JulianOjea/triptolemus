import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triptolemus/constants/shared_preferences_constants.dart';
import 'package:triptolemus/services/api/firebase_service.dart';
import 'package:triptolemus/services/db/category_repository.dart';
import 'package:triptolemus/services/db/question_repository.dart';

import 'package:triptolemus/views/configuration_view.dart';
import 'package:triptolemus/views/custom_question_view.dart';
import 'package:triptolemus/views/game_view.dart';
import 'package:triptolemus/views/home_page_view.dart';
import 'package:triptolemus/views/players_view.dart';
import 'package:triptolemus/views/question_editor.dart';

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  if (message.data.isNotEmpty) {
    if (message.data['download_data'] == 'true') {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('download_data', true);
    }
  }
}

Future<void> checkNeededDBClear() async {
  final prefs = await SharedPreferences.getInstance();
  final pendiente =
      prefs.getBool(SharedPreferencesConstants.downloadData) ?? false;

  if (pendiente) {
    print("borrando la base de datos");
    QuestionRepository.clearDatabase();
    CategoryRepository.clearDatabase();
    prefs.setBool('download_data', false);
  }
}

Future<void> saveTokenOnDB() async {
  final prefs = await SharedPreferences.getInstance();
  final sentToken =
      prefs.getBool(SharedPreferencesConstants.sentToken) ?? false;

  if (sentToken == false) {
    await FirebaseService().saveToken();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyDJRin7sKYVaFggLOKKZGEKskN_0WM5R2I',
    appId: '1:360360637260:android:bee2cbf82cb96b983195e9',
    messagingSenderId: '360360637260',
    projectId: 'triptolemuspushnotifications',
    storageBucket: 'triptolemuspushnotifications.appspot.com',
  ));

  //Save firebase token on db
  saveTokenOnDB();

  final prefs = await SharedPreferences.getInstance();

  //Listening to messages when app is running
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.data['download_data'] == 'true') {
      prefs.setBool('download_data', true);
    }
  });

  //Set up data handler when app is closed
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

  checkNeededDBClear();

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
          page: () => HomePageView(),
        ),
        GetPage(
          name: '/question_editor',
          page: () => const QuestionEditor(),
        )
      ],
    );
  }
}
