// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:triptolemus/constants/colors.dart';

class MainInputText extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;

  const MainInputText({
    Key? key,
    required this.textController,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final playerList = Provider.of<PlayerList>(context);

    return Container(
      padding: const EdgeInsets.only(top: 2, left: 5, bottom: 2, right: 20),
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      height: 60.0,
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
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: hintText),
      ),
    );
  }
}
