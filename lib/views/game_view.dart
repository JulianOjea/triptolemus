import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptolemus/constants/colors.dart';
import 'package:triptolemus/controllers/player_controller.dart';
import 'package:triptolemus/widgets/game_view/player_name_text.dart';
import 'package:triptolemus/widgets/game_view/request_container.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> with TickerProviderStateMixin {
  final playerCtrl = Get.find<PlayerController>();
  late AnimationController _animationTextCtrl;
  late AnimationController _animationTextCtrlEnd;

  @override
  void initState() {
    super.initState();
    _animationTextCtrl = AnimationController(vsync: this);
    _animationTextCtrlEnd = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationTextCtrl.dispose();
    _animationTextCtrlEnd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColor.contrast),
        backgroundColor: AppColor.background,
      ),
      backgroundColor: AppColor.background,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Center(
            child: Column(
          children: [
            PlayerNameText(
              animationCtrl: _animationTextCtrl,
              animationCtrlEnd: _animationTextCtrlEnd,
            ),
            const SizedBox(
              height: 100,
            ),
            RequestContainer(
              animationTextCtrl: _animationTextCtrl,
              animationTextCtrlEnd: _animationTextCtrlEnd,
            ),
          ],
        )),
      ),
    );
  }
}
