import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowy_borders/glowy_borders.dart';

import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/questions_controller.dart';
import 'package:triptolemus/models/category.dart';

class CategorySelector extends StatelessWidget {
  final Category category;
  const CategorySelector({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameCtrl = Get.find<GameController>();
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              gameCtrl.swichActive(category);
            },
            child: Obx(
              () => AnimatedGradientBorder(
                borderSize: 2,
                glowSize: 2,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                gradientColors:
                    //set active hightlight
                    gameCtrl.getCategoryByName(category.value).isActive
                        ? const [
                            Colors.transparent,
                            Colors.transparent,
                            AppColor.secondary,
                            AppColor.contrast
                          ]
                        : const [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent,
                          ],
                //set active color
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: gameCtrl.getCategoryByName(category.value).isActive
                          ? AppColor.primary
                          : AppColor.secondary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                  child: Stack(
                    children: [
                      //emoji container
                      Container(
                        margin: EdgeInsetsDirectional.only(start: 5.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              category.emoji,
                              style: const TextStyle(fontSize: 25.0),
                            )),
                      ),
                      //category text
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          category.value,
                          // category.value != Category.personalizadas
                          //     ? category.value
                          //     //TODO QUITAR ESTO QUE ES DE UNA ITERACION ANTERIOR Y YA NO SIRVE XD
                          //     : "Solo " + category.value,
                          style: const TextStyle(
                              color: AppColor.contrast,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
        // ),
        // SizedBox(
        //   width: 50,
        //   child: Container(
        //     color: Colors.lightGreenAccent,
        //     child: Center(child: Text("P")),
        //   ),
        // )
      ],
    );
  }
}
