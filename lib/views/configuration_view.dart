// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:triptolemus/constants/colors.dart';

class ConfigurationView extends StatefulWidget {
  const ConfigurationView({super.key});

  @override
  State<ConfigurationView> createState() => _ConfigurationViewState();
}

class _ConfigurationViewState extends State<ConfigurationView> {
  int selectedCategory = 0;

  void selectCategory(int index) {
    setState(() {
      selectedCategory = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            const Text(
              "Elige el modo:",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CategorySelector(
                    category: "Category 1",
                    selected: selectedCategory == 0,
                    onTap: () => selectCategory(0),
                  ),
                  const SizedBox(width: 10),
                  CategorySelector(
                    category: "Category 2",
                    selected: selectedCategory == 1,
                    onTap: () => selectCategory(1),
                  ),
                  const SizedBox(width: 10),
                  CategorySelector(
                      category: "Category 3",
                      selected: selectedCategory == 2,
                      onTap: () => selectCategory(2)),
                ],
              ),
            ),
            const SizedBox(height: 25),
            FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, "game");
              },
              child: Icon(Icons.abc),
            )
          ],
        ),
      ),
    );
  }
}

class CategorySelector extends StatelessWidget {
  final String category;
  final bool selected;
  final VoidCallback onTap;

  const CategorySelector({
    Key? key,
    required this.category,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          color: selected ? AppColor.red : AppColor.orange,
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
          category,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        )),
      ),
    );
  }
}
