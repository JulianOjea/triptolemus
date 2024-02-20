// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/player_controller.dart';
import 'package:triptolemus/controllers/questions_controller.dart';
import 'package:triptolemus/widgets/config_view/category_selector.dart';
import 'package:triptolemus/widgets/config_view/config_play_button.dart';

class ConfigurationView extends StatefulWidget {
  const ConfigurationView({super.key});

  @override
  State<ConfigurationView> createState() => _ConfigurationViewState();
}

class _ConfigurationViewState extends State<ConfigurationView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  double _currentSliderValue = 5;
  bool randomSwitch = true;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questionCtrl = Get.find<QuestionController>();
    final playerController = Get.find<PlayerController>();

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
      body: Column(
        children: [
          Expanded(
              child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView(
                onPageChanged: (value) {
                  _tabController.index = value;
                  setState(() {});
                },
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      customSelector(questionCtrl),
                      const SizedBox(
                        height: 20,
                      ),
                      categoryBoxSelectors(questionCtrl),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      nRoundSelector(textController, playerController),
                      const SizedBox(
                        height: 100,
                      ),
                      randomSelector(),
                    ],
                  ),
                ],
              ),
              TabPageSelector(
                controller: _tabController,
                color: Colors.black26,
                selectedColor: AppColor.orange,
                indicatorSize: 16,
                borderStyle: BorderStyle.none,
              )
            ],
          )),
          ConfigPlayButton()
        ],
      ),
    );
  }

  Column randomSelector() {
    return Column(
      children: [
        const Center(
          child: Text(
            "¿Orden aleatorio de jugadores?",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        Switch(
          value: randomSwitch,
          activeColor: AppColor.orange,
          onChanged: (bool value) {
            setState(() {
              randomSwitch = value;
            });
          },
        ),
      ],
    );
  }

  Column categoryBoxSelectors(QuestionController questionCtrl) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            "¿Con qué categorías te gustaría jugar?",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 25),
        CategorySelector(emoji: '🤔', category: questionCtrl.categories[0]),
        CategorySelector(emoji: '😱', category: questionCtrl.categories[2]),
        CategorySelector(emoji: '👻', category: questionCtrl.categories[1]),
        CategorySelector(emoji: '🤯', category: questionCtrl.categories[3]),
        const SizedBox(height: 25),
      ],
    );
  }

  Column customSelector(QuestionController questionCtrl) {
    return Column(
      children: [
        const Center(
          child: Text(
            "¿Quieres jugar con tus preguntas personalizadas?",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        Obx(() => Switch(
              value: questionCtrl.insertQustomCuestion.value,
              activeColor: AppColor.orange,
              onChanged: (bool value) {
                questionCtrl.insertQustomCuestion.value = value;
              },
            )),
        const SizedBox(height: 25),
      ],
    );
  }

  Column nRoundSelector(
      TextEditingController textController, PlayerController playerController) {
    return Column(
      children: [
        const Text(
          "¿Cuantas rondas quieres jugar?",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 25),
        SizedBox(
            height: 20,
            child: SliderTheme(
              data: const SliderThemeData(trackHeight: 10),
              child: Slider(
                  activeColor: AppColor.orange,
                  value: _currentSliderValue,
                  max: 10,
                  divisions: 10,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      playerController.nRounds.value = value.round();
                      _currentSliderValue = value;
                      textController.text = value.toString();
                    });
                  }),
            )),
        const SizedBox(height: 25),
      ],
    );
  }
}
