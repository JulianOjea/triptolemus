// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/questions_controller.dart';
import 'package:triptolemus/widgets/config_view/category_selector.dart';
import 'package:triptolemus/widgets/config_view/config_play_button.dart';

class ConfigurationView extends StatefulWidget {
  const ConfigurationView({super.key});

  @override
  State<ConfigurationView> createState() => _ConfigurationViewState();
}

class _ConfigurationViewState extends State<ConfigurationView> {
  double _currentSliderValue = 5;
  bool light = true;

  @override
  Widget build(BuildContext context) {
    final questionCtrl = Get.find<QuestionController>();
    //final playerCtrl = Get.find<PlayerController>();

    TextEditingController textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.blue,
        title: const Text(
          "Configura tu partida",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
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
                      height: 20,
                      child: SliderTheme(
                        data: SliderThemeData(trackHeight: 10),
                        child: Slider(
                            activeColor: AppColor.orange,
                            value: _currentSliderValue,
                            max: 10,
                            divisions: 10,
                            label: _currentSliderValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValue = value;
                                textController.text = value.toString();
                              });
                            }),
                      )),
                  SizedBox(height: 25),
                  const Center(
                    child: Text(
                      "¿Quieres jugar con tus preguntas personalizadas?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Switch(
                    value: light,
                    activeColor: AppColor.orange,
                    onChanged: (bool value) {
                      setState(() {
                        light = value;
                      });
                    },
                  ),
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
                  Row(
                    children: [
                      Expanded(
                          child: CategorySelector(
                              emoji: '🤔',
                              category: questionCtrl.categories[0])),
                      Expanded(
                          child: CategorySelector(
                              emoji: '😱',
                              category: questionCtrl.categories[3])),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CategorySelector(
                              emoji: '👻',
                              category: questionCtrl.categories[2])),
                      Expanded(
                          child: CategorySelector(
                              emoji: '🤯',
                              category: questionCtrl.categories[1])),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Center(
                    child: Text(
                      "¿Orden aleatorio de jugadores?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Switch(
                    value: light,
                    activeColor: AppColor.orange,
                    onChanged: (bool value) {
                      setState(() {
                        light = value;
                      });
                    },
                  )
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
