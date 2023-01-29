import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  static ThemeManager? instance;

  static const Color whiteColor = Color(0xFFF0ECCF);

  static const Color greyColor = Color.fromARGB(255, 158, 158, 157);

  static const Color primaryColor = Color(0xFFFFB100);
  static const Color darkPrimaryColor = Color.fromARGB(255, 219, 155, 4);

  static const Color secondaryColor = Color(0xFFFBC252);
  static const Color darkSecondaryColor = Color.fromARGB(255, 216, 165, 63);

  static const Color textColor = Color.fromARGB(255, 56, 56, 56);

  static const Color primaryAccent = Color(0xFFA3BB98);

  static const double defaultFontSize = 16;

  static ThemeManager getThemeManager() {
    // if instance == null then make new instance. SINGLETON
    instance ??= ThemeManager();
    return instance!;
  }

  ThemeMode _themeMode = ThemeMode.light;

  get themeMode {
    return _themeMode;
  }

  void toggleTheme(bool isDark) {
    if (isDark == false) {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }
}
