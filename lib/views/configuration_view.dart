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
    final gameCtrl = Get.find<GameController>();
    final playerController = Get.find<PlayerController>();

    TextEditingController textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.background,
        iconTheme: const IconThemeData(
          color: AppColor.contrast, //change your color here
        ),
        title: const Text(
          "Configura tu partida",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: AppColor.contrast),
        ),
      ),
      backgroundColor: AppColor.background,
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
                        height: 20,
                      ),
                      categoryBoxSelectors(gameCtrl),
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
                      randomSelector(playerController),
                    ],
                  ),
                ],
              ),
              TabPageSelector(
                controller: _tabController,
                color: AppColor.secondary,
                selectedColor: AppColor.primary,
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

  Column randomSelector(PlayerController playerController) {
    return Column(
      children: [
        const Center(
          child: Text(
            "¿Orden aleatorio de jugadores?",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.contrast,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        Switch(
          inactiveThumbColor: AppColor.secondary,
          inactiveTrackColor: AppColor.primary,
          value: playerController.isRandomSort.value,
          activeColor: AppColor.primary,
          onChanged: (bool value) {
            setState(() {
              playerController.isRandomSort.value = value;
            });
          },
        ),
      ],
    );
  }

  Column categoryBoxSelectors(GameController gameCtrl) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            "¿Con qué categorías te gustaría jugar?",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.contrast,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 25),
        ...getSelectors(gameCtrl),
        const SizedBox(height: 25),
      ],
    );
  }

  List<CategorySelector> getSelectors(GameController gameCtrl) {
    return gameCtrl.categories.map((c) {
      return CategorySelector(category: c);
    }).toList();
  }

  // Column customSelector(QuestionController gameCtrl) {
  //   return Column(
  //     children: [
  //       const Center(
  //         child: Text(
  //           "¿Quieres jugar con tus preguntas personalizadas?",
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //               color: AppColor.contrast,
  //               fontSize: 25,
  //               fontWeight: FontWeight.bold),
  //         ),
  //       ),
  //       Obx(() => Switch(
  //             inactiveThumbColor: AppColor.secondary,
  //             inactiveTrackColor: AppColor.primary,
  //             value: gameCtrl.insertQustomCuestion.value,
  //             activeColor: AppColor.primary,
  //             onChanged: (bool value) {
  //               gameCtrl.insertQustomCuestion.value = value;
  //             },
  //           )),
  //       const SizedBox(height: 25),
  //     ],
  //   );
  // }

  Column nRoundSelector(
      TextEditingController textController, PlayerController playerController) {
    return Column(
      children: [
        const Text(
          "¿Cuantas rondas quieres jugar?",
          style: TextStyle(
              color: AppColor.contrast,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 25),
        SizedBox(
            height: 20,
            child: SliderTheme(
              data: const SliderThemeData(trackHeight: 10),
              child: Slider(
                  activeColor: AppColor.primary,
                  inactiveColor: AppColor.secondary,
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
