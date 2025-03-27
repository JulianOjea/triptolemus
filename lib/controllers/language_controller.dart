import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  var locale = const Locale('en', 'US').obs; // Idioma por defecto

  @override
  void onReady() {
    _loadSavedLanguage();
    super.onReady();
  }

  void changeLanguage(String langCode) async {
    var newLocale = Locale(langCode);
    locale.value = newLocale;
    Get.updateLocale(newLocale);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', langCode);
  }

  void _loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLangCode = prefs.getString('language_code');

    if (savedLangCode != null) {
      locale.value = Locale(savedLangCode);
      Get.updateLocale(locale.value);
    }
  }
}
