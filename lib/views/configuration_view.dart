// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/player_controller.dart';
import 'package:triptolemus/controllers/questions_controller.dart';
import 'package:triptolemus/widgets/category_selector.dart';
import 'package:triptolemus/widgets/config_view/config_play_button.dart';

class ConfigurationView extends StatefulWidget {
  const ConfigurationView({super.key});

  @override
  State<ConfigurationView> createState() => _ConfigurationViewState();
}

class _ConfigurationViewState extends State<ConfigurationView> {
  double _currentSliderValue = 5;
  // int selectedCategory = 0;

  // void selectCategory(int index) {
  //   setState(() {
  //     selectedCategory = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final questionCtrl = Get.find<QuestionController>();
    final playerCtrl = Get.find<PlayerController>();

    TextEditingController textController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColor.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "¿Cuantas rondas quieres jugar?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),
                  Container(
                      child: Slider(
                          value: _currentSliderValue,
                          max: 10,
                          divisions: 10,
                          label: _currentSliderValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValue = value;
                              textController.text = value.toString();
                              print(value);
                            });
                          })),
                  const SizedBox(height: 25),
                  const Center(
                    child: Text(
                      "¿Con qué categorías te gustaría jugar?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        CategorySelector(category: questionCtrl.categories[0]),
                        const SizedBox(width: 10),
                        CategorySelector(category: questionCtrl.categories[1]),
                        const SizedBox(width: 10),
                        CategorySelector(category: questionCtrl.categories[2]),
                        const SizedBox(width: 10),
                        CategorySelector(category: questionCtrl.categories[3]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            ConfigPlayButton()
          ],
        ),
      ),
    );
  }
}
