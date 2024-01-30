// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/models/category.dart';
import 'package:triptolemus/services/questions_service.dart';

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
    TextEditingController textController = TextEditingController();
    const CategorySelector dilemaSelector = CategorySelector(
      category: QuestionCategory.dilemas,
      selected: true,
      // onTap: () => selectCategory(0),
    );
    const CategorySelector picanteSelector = CategorySelector(
      category: QuestionCategory.picante,
      selected: false,
      // onTap: () => selectCategory(0),
    );
    const CategorySelector confidencialesSelector = CategorySelector(
      category: QuestionCategory.confidenciales,
      selected: false,
      // onTap: () => selectCategory(0),
    );
    const CategorySelector personalizadaSelector = CategorySelector(
      category: QuestionCategory.personalizada,
      selected: false,
      // onTap: () => selectCategory(0),
    );

    List<CategorySelector> categorySelectorList = [
      dilemaSelector,
      picanteSelector,
      confidencialesSelector,
      personalizadaSelector
    ];
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
                  categorySelectorList[0],
                  const SizedBox(width: 10),
                  categorySelectorList[1],
                  const SizedBox(width: 10),
                  categorySelectorList[2],
                  // onTap: () => selectCategory(2)),
                  const SizedBox(width: 10),
                  categorySelectorList[3]
                ],
              ),
            ),
            const SizedBox(height: 25),
            FloatingActionButton(
              onPressed: () {
                final questionService =
                    Provider.of<QuestionService>(context, listen: false);
                List<QuestionCategory> categoryList = categorySelectorList
                    .where((element) => element.selected)
                    .map((e) => e.category)
                    .toList();
                categoryList.map((e) => questionService.addActiveCategory(e));
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

class CategorySelector extends StatefulWidget {
  final QuestionCategory category;
  final bool selected;
  // final VoidCallback onTap;

  const CategorySelector({
    Key? key,
    required this.category,
    required this.selected,
    // required this.onTap,
  }) : super(key: key);

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  bool stateSelected = false;

  @override
  void initState() {
    stateSelected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          stateSelected ? stateSelected = false : stateSelected = true;
        });
      },
      child: Container(
        height: 40,
        width: 150,
        decoration: BoxDecoration(
          color: stateSelected ? AppColor.red : AppColor.orange,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.10),
                offset: const Offset(0, 10),
                blurRadius: 5),
          ],
        ),
        child: Center(
            child: Text(
          widget.category.value,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        )),
      ),
    );
  }
}
