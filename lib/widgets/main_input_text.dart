// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/player_controller.dart';

class MainInputText extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final BorderRadius borderRadius;

  const MainInputText({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playerCtrl = Get.find<PlayerController>();

    return Container(
      padding: const EdgeInsets.only(top: 2, left: 5, bottom: 2, right: 20),
      height: 60.0,
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: borderRadius,
      ),
      child: TextField(
        onTap: () => playerCtrl.setIsEditing(false),
        controller: textController,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: AppColor.contrast),
        decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColor.contrast)),
      ),
    );
  }
}
