import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/player_controller.dart';
import 'package:triptolemus/controllers/questions_controller.dart';
import 'package:triptolemus/widgets/home_view/home_play_button.dart';
import 'package:triptolemus/widgets/home_view/home_to_custom_question_button.dart';

class HomePageView extends StatelessWidget {
  HomePageView({super.key});

  final questionCtrl = Get.put(QuestionController());
  final playerCtrl = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
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
                    HomeCustomQuestionButton()
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
