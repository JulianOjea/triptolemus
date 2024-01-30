import 'package:triptolemus/models/category.dart';
import 'package:triptolemus/models/question.dart';

class Questions {
  static List<Question> questionList = [
    Question("Cuando fue tu primer beso?", QuestionCategory.picante),
    Question("Cual es tu hábito más xX_GROSERO_Xx :P",
        QuestionCategory.confidenciales),
    Question("Has espiado a tu crush?", QuestionCategory.picante),
    Question("Cual es el momento más vergonzoso de tu vida?",
        QuestionCategory.confidenciales),
    Question(
        "¿Hay algo que nunca le hayas dicho a %name% y que deberías haberle dicho?",
        QuestionCategory.confidenciales),
    Question("¿Alguna vez has tenido un sueño extraño sobre %name%?",
        QuestionCategory.confidenciales),
    Question(
        "¿Cuál es la primera impresión que tuviste de %name% cuando lo conociste?",
        QuestionCategory.confidenciales),
    Question("¿Qué es lo que más odias de %name% y por qué?",
        QuestionCategory.confidenciales),
    Question("¿Dónde te haces las gallardas?", QuestionCategory.picante),
    Question("¿Le harías una gallarda a %name%?", QuestionCategory.picante),
    Question("La apuesta de Pascal", QuestionCategory.dilemas),
    Question("La mala fe de Sartre", QuestionCategory.dilemas),
    Question(
        "Si hay una cabra que te tienes que asignar y te miran es mejor que no temiren?",
        QuestionCategory.dilemas),
    Question(
        "¿Elijes pelearte mucho contra lagartos o mucho contra otro tipo de lagarto?",
        QuestionCategory.dilemas),
    Question(
        "¿Elijes entre, atento, elijes entre, darte placer o entre tomarte un COLACADO; DILEMA ESCUCHEN a %name% que tiene que decir tambien",
        QuestionCategory.dilemas),
  ];
}
