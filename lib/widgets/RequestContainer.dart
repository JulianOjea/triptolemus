import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triptolemus/data/questions.dart';
import 'package:triptolemus/services/player_service.dart';

class RequestContainer extends StatefulWidget {
  const RequestContainer({
    super.key,
  });

  @override
  State<RequestContainer> createState() => _RequestContainerState();
}

class _RequestContainerState extends State<RequestContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 300.0, end: 0).animate(_controller);

    // Escuchar el cambio de estado de la animación
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Cuando la animación llega al final, revertir la animación
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        // Cuando la animación se revierte completamente, avanzar nuevamente
        //_controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final playerService = Provider.of<PlayerList>(context);

    return Column(
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20.0)),
              width: _animation.value,
              height: _animation.value,
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  Questions.getQuestion(
                      playerService.getRandomPlayerWithoutActual().name),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
        const SizedBox(
          height: 50,
        ),
        FloatingActionButton(
            child: const Icon(Icons.add_road),
            onPressed: () {
              playerService.nextPlayer();
              _controller.forward();
            })
      ],
    );
  }
}
