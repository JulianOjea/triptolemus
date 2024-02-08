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
    return const Scaffold(
      backgroundColor: AppColor.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomePlayButton(),
            SizedBox(
              height: 20,
            ),
            HomeCustomQuestionButton()
          ],
        ),
      ),
    );
  }
}
