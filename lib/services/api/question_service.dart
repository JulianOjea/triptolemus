import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:triptolemus/models/question.dart';
import 'package:triptolemus/constants/uris.dart';

class QuestionService {
  static Future<List<Question>> fetchQuestions() async {
    print("FETCHING QUESTIONS" + DateTime.now().toString());
    try {
      final response = await http.get(Uri.parse(AppUri.questionEndpoint));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        return data.map((item) => Question.fromJson(item)).toList();
      } else {
        throw Exception('Error getting questions ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Unexpected error getting question');
    }
  }
}
