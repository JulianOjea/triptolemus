import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triptolemus/constants/uris.dart';
import 'package:triptolemus/constants/shared_preferences_constants.dart';

class FirebaseService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> saveToken() async {
    final token = await _firebaseMessaging.getToken();
    final body = {"token_fcm": token};
    final response = await http.post(
      Uri.parse(AppUri.saveTokenEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(SharedPreferencesConstants.sentToken, true);
    }
  }
}
