// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/questions_controller.dart';
import 'package:triptolemus/models/category.dart';

class CategorySelector extends StatelessWidget {
  final QuestionCategory category;

  const CategorySelector({
    Key? key,
    required this.category,
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
            height: 40,
            width: 150,
            decoration: BoxDecoration(
              color: questionCtrl.getCategoryByName(category.value).isActive
                  ? AppColor.red
                  : AppColor.orange,
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
              category.value,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            )),
          ),
        ));
  }
}
