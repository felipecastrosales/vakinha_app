import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static AppColors? _instance;

  static AppColors get instance {
    _instance ??= AppColors._();
    return _instance!;
  }

  Color get primary => const Color(0xFF007D21);
  Color get secondary => const Color(0xFFF88B0C);
}

extension AppColorsExtensions on BuildContext {
  AppColors get appColors => AppColors.instance;
}
