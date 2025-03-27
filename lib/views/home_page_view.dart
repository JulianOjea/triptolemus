import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/language_controller.dart';
import 'package:triptolemus/controllers/player_controller.dart';
import 'package:triptolemus/controllers/questions_controller.dart';
import 'package:triptolemus/widgets/home_view/home_play_button.dart';

class HomePageView extends StatelessWidget {
  HomePageView({super.key});

  final questionCtrl = Get.put(GameController());
  final playerCtrl = Get.put(PlayerController());
  final langController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        actions: [
          IconButton(
            icon: Obx(() {
              // Mostrar la bandera según el idioma actual
              String languageCode = langController.locale.value.languageCode;
              return Image.asset(
                'assets/${languageCode == 'en' ? 'en' : 'es'}.png',
                width: 30, // Tamaño de la bandera
              );
            }),
            onPressed: () {
              // Cambiar el idioma cuando se presione el botón
              String newLang = langController.locale.value.languageCode == 'en'
                  ? 'es'
                  : 'en';
              langController.changeLanguage(newLang);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Container(
          //   decoration: new BoxDecoration(
          //       image: DecorationImage(
          //           image: AssetImage("assets/test.jpeg"), fit: BoxFit.cover)),
          // ),
          Center(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Container(
                        alignment: Alignment.topCenter,
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/logo1.jpeg'),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.circle,
                        )),
                  ],
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomePlayButton(),
                    SizedBox(
                      height: 20,
                    ),
                    //TODO costom question implementation for future
                    // implementation
                    //HomeCustomQuestionButton()
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
