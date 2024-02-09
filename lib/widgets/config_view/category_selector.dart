// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:get/get.dart';

import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/questions_controller.dart';
import 'package:triptolemus/models/category.dart';

class CategorySelector extends StatelessWidget {
  final QuestionCategory category;
  final String emoji;
  const CategorySelector({
    Key? key,
    required this.category,
    required this.emoji,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final questionCtrl = Get.find<QuestionController>();

    return GestureDetector(
        onTap: () {
          questionCtrl.swichActive(category);
        },
        child: Obx(
          () => Container(
            margin: const EdgeInsets.all(10.0),
            height: 40,
            decoration: BoxDecoration(
              color: questionCtrl.getCategoryByName(category.value).isActive
                  ? AppColor.red
                  : AppColor.orange,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    offset: const Offset(0, 10),
                    blurRadius: 5),
              ],
            ),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(start: 5.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        emoji,
                        style: const TextStyle(fontSize: 25.0),
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    category.value != QuestionCategory.personalizada
                        ? category.value
                        : "Solo " + category.value + "s",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
