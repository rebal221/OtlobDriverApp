
import 'dart:ui';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../preferences/app_preferences.dart';

class AppGet extends GetxController {

  Locale localeUse = Locale('ar', 'AE');

  setUpdateLocale({required Locale locale}) {
    if (locale == const Locale('en', 'US')) {
      AppPreferences().saveLocale(languageCode: 'en', countryCode: 'US');
    } else if (locale == const Locale('ar', 'AE')) {
      AppPreferences().saveLocale(languageCode: 'ar', countryCode: 'AE');
    } else if (locale == const Locale('fr', 'FR')) {
      AppPreferences().saveLocale(languageCode: 'fr', countryCode: 'FR');
    } else if (locale == const Locale('ru', 'RU')) {
      AppPreferences().saveLocale(languageCode: 'ru', countryCode: 'RU');
    }
    Get.updateLocale(locale);
  }
}
