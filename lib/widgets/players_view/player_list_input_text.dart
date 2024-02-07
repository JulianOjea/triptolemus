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

    return Container(
      padding: const EdgeInsets.only(top: 2, left: 5, bottom: 2, right: 20),
      height: 60.0,
      decoration: BoxDecoration(
        color: AppColor.orange,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black.withOpacity(0.10),
              offset: const Offset(0, 10),
              blurRadius: 5),
        ],
      ),
      child: TextField(
        onChanged: (val) {
          print(val);
          print("he cambiado");
        },
        onEditingComplete: () {
          print("acabo de terminar de editar este campo");
        },
        onTap: () {
          playerCtrl.setIsEditing(true);
        },
        controller: textController,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => playerCtrl.removeAt(index),
            ),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: 'Escribe un nombre'),
      ),
    );
  }
}
