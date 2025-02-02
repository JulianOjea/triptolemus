import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:triptolemus/constants/uris.dart';
import 'package:triptolemus/models/category.dart';

class CategoryService {
  static Future<List<Category>> fetchCategories() async {
    print("FETCHING CATEGORIES${DateTime.now()}");
    try {
      final response = await http.get(Uri.parse(AppUri.categoryEndpoint));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        return data.map((item) => Category.fromJson(item)).toList();
      } else {
        throw Exception('Error getting category ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Unexpected error getting category');
    }
  }
}
