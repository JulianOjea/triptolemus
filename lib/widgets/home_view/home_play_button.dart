import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:triptolemus/constants/colors.dart';

class HomePlayButton extends StatelessWidget {
  const HomePlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/players');
      },
      child: AnimatedGradientBorder(
        borderSize: 2,
        glowSize: 10,
        borderRadius: const BorderRadius.all(Radius.circular(1)),
        gradientColors: const [
          Colors.redAccent,
          AppColor.contrast,
          Colors.yellow,
          AppColor.secondary,
        ],
        child: Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              )),
          child: const Icon(
            Icons.play_arrow_rounded,
            size: 80,
            color: AppColor.contrast,
          ),
        ),
      ),
    );
  }
}
