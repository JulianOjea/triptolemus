// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/questions_controller.dart';
import 'package:triptolemus/widgets/category_selector.dart';

class ConfigurationView extends StatefulWidget {
  const ConfigurationView({super.key});

  @override
  State<ConfigurationView> createState() => _ConfigurationViewState();
}

class _ConfigurationViewState extends State<ConfigurationView> {
  // int selectedCategory = 0;

  // void selectCategory(int index) {
  //   setState(() {
  //     selectedCategory = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final questionCtrl = Get.put(QuestionController());

    TextEditingController textController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColor.blue,
      body: Center(
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
              padding:
                  const EdgeInsets.only(top: 2, left: 5, bottom: 2, right: 20),
              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                color: AppColor.orange,
                borderRadius: BorderRadius.circular(30),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      offset: const Offset(0, 10),
                      blurRadius: 5),
                ],
              ),
              child: TextField(
                controller: textController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: "1"),
              ),
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
            const SizedBox(height: 25),
            FloatingActionButton(
              onPressed: () {
                // List<QuestionCategory> categoryList = categorySelectorList
                //     .where((element) => element.selected)
                //     .map((e) => e.category)
                //     .toList();
                // categoryList.map((e) => questionCtrl.addActiveCategory(e));
                Navigator.pushNamed(context, "game");
              },
              child: const Icon(Icons.abc),
            )
          ],
        ),
      ),
    );
  }
}
