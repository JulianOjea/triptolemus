// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/player_controller.dart';

class PlayerListInputText extends StatelessWidget {
  final TextEditingController textController;
  final int index;
  const PlayerListInputText({
    Key? key,
    required this.textController,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playerCtrl = Get.find<PlayerController>();
    textController.selection =
        TextSelection.collapsed(offset: textController.text.length);
    return Container(
      padding: const EdgeInsets.only(top: 2, left: 5, bottom: 2, right: 20),
      height: 60.0,
      decoration: const BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          )),
      child: TextField(
        onChanged: (val) {
          playerCtrl.setPlayerValueAt(val, index);
        },
        onTap: () {
          playerCtrl.setIsEditing(true);
        },
        controller: textController,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: AppColor.contrast),
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.remove,
                color: AppColor.contrast,
              ),
              onPressed: () => playerCtrl.removeAt(index),
            ),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: 'Escribe un nombre',
            hintStyle: TextStyle(color: AppColor.contrast)),
      ),
    );
  }
}
