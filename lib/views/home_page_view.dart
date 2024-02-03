import 'package:flutter/material.dart';
import 'package:triptolemus/views/custom_question_view.dart';
import 'package:triptolemus/views/players_view.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return PageView(
      controller: controller,
      children: const [PlayersView(), CustomQuestionView()],
    );
  }
}
