import 'package:get/get.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'my questions': 'My Questions',
          'players': "Players",
          'Añade jugadores para jugar 😀': 'Add players to play 😀',
          'Escribe un nombre': 'Write a name'
        },
        'es': {
          'my questions': 'Mis Preguntas',
          'players': "Jugadores",
          'Añade jugadores para jugar 😀': 'Añade jugadores para jugar 😀',
          'Escribe un nombre': 'Escribe un nombre'
        },
      };
}
